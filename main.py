from fastapi import FastAPI
import torch

app = FastAPI()

@app.get("/health")
def health():
  return {"status": "ok"}

@app.get("/info")
def info():
  return {
    "device_count": torch.cuda.device_count(),
    "cuda_available": torch.cuda.is_available(),
    "gpu_name": torch.cuda.get_device_name()
  }
