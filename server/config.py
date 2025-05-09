import os
from dotenv import load_dotenv

load_dotenv()

VITO_AUTH_URL = "https://openapi.vito.ai/v1/authenticate"
VITO_TRANSCRIBE_URL = "https://openapi.vito.ai/v1/transcribe"
VITO_RESULT_URL = "https://openapi.vito.ai/v1/transcribe"

CLIENT_ID = os.getenv("VITO_CLIENT_ID")
CLIENT_SECRET = os.getenv("VITO_CLIENT_SECRET")
