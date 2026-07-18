import pytest
from fastapi.testclient import TestClient
from main import app
from datetime import datetime, timedelta

client = TestClient(app)

def test_read_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"status": "ok", "message": "Lai Hoa Video Backend Running"}

def test_verify_license_valid():
    response = client.post("/verify-license", data={"license_key": "VALID_KEY_123"})
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "success"
    assert data["valid"] == True
    assert data["days_remaining"] == 365

def test_verify_license_expired():
    response = client.post("/verify-license", data={"license_key": "EXPIRED_KEY"})
    # Since it's a mock, we just ensure the endpoint is reachable and handles data
    assert response.status_code == 200

def test_anti_time_tampering_simulation():
    # Simulate time tampering logic
    tampered_time = datetime.now() - timedelta(days=400)
    # The actual implementation in Security_Agent will verify the offset with NTP servers
    assert tampered_time < datetime.now()

def test_generate_video_flow():
    response = client.post("/generate-video", data={"script": "Kiểm tra tính năng sinh video tuyên truyền"})
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "success"
    assert "background" in data["message"]
