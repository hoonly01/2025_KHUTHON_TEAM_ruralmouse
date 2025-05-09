import requests
import json
import os
import logging
import time
from datetime import datetime
from config import VITO_TRANSCRIBE_URL, VITO_RESULT_URL
from auth import get_jwt_token
from models import Transcription, get_db
from sqlalchemy.orm import Session

# 로깅 설정
def setup_logger():
    # logs 디렉토리 생성
    if not os.path.exists('logs'):
        os.makedirs('logs')
    
    # 로거 설정
    logger = logging.getLogger('transcribe')
    logger.setLevel(logging.INFO)
    
    # 파일 핸들러 설정 (날짜별 로그 파일)
    log_filename = f'logs/transcribe_{datetime.now().strftime("%Y%m%d")}.log'
    file_handler = logging.FileHandler(log_filename, encoding='utf-8')
    file_handler.setLevel(logging.INFO)
    
    # 포맷터 설정
    formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
    file_handler.setFormatter(formatter)
    
    # 핸들러 추가
    logger.addHandler(file_handler)
    
    return logger

# 결과 저장 디렉토리 설정
def setup_results_dir():
    if not os.path.exists('results'):
        os.makedirs('results')

def save_transcription_result(result, filename):
    """변환 결과를 JSON 파일로 저장"""
    setup_results_dir()
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    result_filename = f'results/transcription_{timestamp}_{filename}.json'
    
    with open(result_filename, 'w', encoding='utf-8') as f:
        json.dump(result, f, ensure_ascii=False, indent=2)
    
    return result_filename

def get_transcription_result(task_id):
    """작업 ID로 변환 결과를 조회"""
    token = get_jwt_token()
    headers = {
        "accept": "application/json",
        "Authorization": f"Bearer {token}",
    }
    
    while True:
        response = requests.get(f"{VITO_RESULT_URL}/{task_id}", headers=headers)
        if response.status_code != 200:
            raise Exception(f"Failed to get transcription result: {response.text}")
        
        result = response.json()
        if result.get("status") == "completed":
            return result
        elif result.get("status") == "failed":
            raise Exception("Transcription failed")
        
        time.sleep(1)  # 1초 대기 후 다시 조회

def save_to_db(db: Session, filename: str, result_file: str, result: dict):
    """변환 결과를 DB에 저장"""
    # 변환된 텍스트 추출
    transcription_text = ""
    speaker_info = []
    
    if "results" in result and "utterances" in result["results"]:
        for utterance in result["results"]["utterances"]:
            text = utterance.get("msg", "")
            speaker = utterance.get("spk", "unknown")
            start = utterance.get("start_at", 0)
            duration = utterance.get("duration", 0)
            
            transcription_text += f"[화자{speaker}] {text}\n"
            speaker_info.append({
                "speaker": speaker,
                "text": text,
                "start": start,
                "end": start + duration
            })

    # DB에 저장
    db_transcription = Transcription(
        filename=filename,
        result_file=result_file,
        transcription_text=transcription_text,
        speaker_info=speaker_info,
        status="completed"
    )
    db.add(db_transcription)
    db.commit()
    db.refresh(db_transcription)
    return db_transcription

def transcribe_audio(file, config: dict, db: Session):
    logger = setup_logger()
    
    try:
        # 시작 로깅
        logger.info(f"Starting transcription for file: {file.filename}")
        
        # VITO API 토큰 획득
        token = get_jwt_token()
        logger.info("Successfully obtained VITO API token")
        
        headers = {
            "accept": "application/json",
            "Authorization": f"Bearer {token}",
        }
        
        files = {
            "file": (file.filename, file.file, "audio/wav"),
            "config": (None, json.dumps(config), "application/json")
        }
        
        # API 호출
        logger.info("Sending request to VITO API")
        response = requests.post(VITO_TRANSCRIBE_URL, headers=headers, files=files)
        
        # 응답 확인
        if response.status_code != 200:
            error_msg = f"VITO API error: {response.status_code} - {response.text}"
            logger.error(error_msg)
            raise Exception(error_msg)
        
        # 작업 ID 받기
        task_id = response.json().get("id")
        logger.info(f"Received task ID: {task_id}")
        
        # 결과 조회
        logger.info("Waiting for transcription result...")
        result = get_transcription_result(task_id)
        logger.info("Successfully received transcription result")
        
        # 결과 저장
        saved_file = save_transcription_result(result, file.filename)
        logger.info(f"Saved transcription result to: {saved_file}")
        
        # DB에 저장
        db_result = save_to_db(db, file.filename, saved_file, result)
        logger.info(f"Saved transcription to database with ID: {db_result.id}")
        
        return {
            "status": "success",
            "result": result,
            "saved_file": saved_file,
            "db_id": db_result.id
        }
        
    except Exception as e:
        error_msg = f"Transcription error: {str(e)}"
        logger.error(error_msg)
        raise Exception(error_msg)