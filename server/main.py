from fastapi import FastAPI, UploadFile, File, HTTPException, Depends
from fastapi.responses import JSONResponse
import uvicorn
import logging
from sqlalchemy.orm import Session

from transcribe import transcribe_audio
from auth import get_jwt_token
from models import get_db, Transcription

app = FastAPI()

# 로깅 설정
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

@app.get("/token")
async def get_token():
    try:
        token = get_jwt_token()
        return {"token": token}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/transcribe")
async def transcribe(file: UploadFile = File(...), db: Session = Depends(get_db)):
    try:
        logger.info(f"Received transcription request for file: {file.filename}")
        
        config = {
            "use_diarization": True,
            "diarization": {
                "spk_count": 2
            },
            "use_itn": False,
            "use_disfluency_filter": False,
            "use_profanity_filter": False,
            "use_paragraph_splitter": True,
            "paragraph_splitter": {
                "max": 50
            }
        }
        
        result = transcribe_audio(file, config, db)
        logger.info(f"Transcription completed successfully. Result saved to: {result['saved_file']}")
        
        return JSONResponse(content=result)
    except Exception as e:
        error_msg = f"Transcription failed: {str(e)}"
        logger.error(error_msg)
        raise HTTPException(status_code=500, detail=error_msg)

@app.get("/transcriptions")
async def get_transcriptions(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    transcriptions = db.query(Transcription).offset(skip).limit(limit).all()
    return transcriptions

@app.get("/transcriptions/{transcription_id}")
async def get_transcription(transcription_id: int, db: Session = Depends(get_db)):
    transcription = db.query(Transcription).filter(Transcription.id == transcription_id).first()
    if transcription is None:
        raise HTTPException(status_code=404, detail="Transcription not found")
    return transcription


if __name__ == "__main__":
    uvicorn.run("main:app", host="localhost", port=8080, reload=True)


