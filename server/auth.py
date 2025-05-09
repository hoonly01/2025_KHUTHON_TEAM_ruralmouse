import requests
import time
from config import VITO_AUTH_URL, CLIENT_ID, CLIENT_SECRET

_cached_token = None
_token_expiry = 0  # 토큰 만료 시간

def get_jwt_token():
    global _cached_token, _token_expiry
    
    # 토큰이 있고 만료되지 않았다면 캐시된 토큰 반환
    current_time = time.time()
    if _cached_token and current_time < _token_expiry:
        return _cached_token

    # 새 토큰 발급
    data = {
        "client_id": CLIENT_ID,
        "client_secret": CLIENT_SECRET,
    }
    headers = {
        "accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
    }

    response = requests.post(VITO_AUTH_URL, headers=headers, data=data)
    if response.status_code == 200:
        _cached_token = response.json().get("access_token")
        # 토큰 만료 시간 설정 (기본 1시간)
        _token_expiry = current_time + 3600
        return _cached_token
    else:
        raise Exception("Failed to get JWT token from Vito")
