FROM python:3.11-slim-bullseye

WORKDIR /app

# Install compiler C, header, dan Rust (buat paket cryptography/aiohttp)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    libssl-dev \
    libffi-dev \
    python3-dev \
    rustc \
    cargo \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

# Upgrade pip/setuptools/wheel dulu, baru install
RUN python -m pip install --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PYTHONUNBUFFERED=1
ENV PORT=8080

EXPOSE ${PORT}

CMD ["python", "app.py"]
