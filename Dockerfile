# Use PyTorch CUDA base image
FROM pytorch/pytorch:2.5.0-cuda12.4-cudnn9-runtime

# Set Python environment variables
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt \
    transformers

# Download Huggingface model
# Replace "model-name" with your desired model
RUN python3 -c "from transformers import AutoModel; AutoModel.from_pretrained('Tap-M/Luna-AI-Llama2-Uncensored', cache_dir='/app/model')"

# Copy the application code
COPY main.py .

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
