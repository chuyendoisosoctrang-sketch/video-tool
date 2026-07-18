import os
from fastapi import FastAPI, UploadFile, Form
from fastapi.middleware.cors import CORSMiddleware
from dotenv import load_dotenv

load_dotenv()

app = FastAPI(title="Lai Hoa Video API")

# Setup CORS for Flutter Web App
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], # Should be restricted in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def read_root():
    return {"status": "ok", "message": "Lai Hoa Video Backend Running"}

@app.post("/verify-license")
async def verify_license(license_key: str = Form(...)):
    # Logic to verify license and anti-time-tampering
    # Return 365 days or expired
    return {"status": "success", "valid": True, "days_remaining": 365}

@app.post("/generate-video")
async def generate_video(script: str = Form(...)):
    # 1. License Check & Rate Limiting
    # 2. Process text with Gemini
    # 3. Generate Audio with Edge-TTS
    # 4. Render Video with FFmpeg
    # 5. Upload to Google Drive
    return {"status": "success", "message": "Video is being generated in background."}
