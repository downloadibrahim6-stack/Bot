FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

ENV RUSTUP_HOME=/tmp/.rustup
ENV CARGO_HOME=/tmp/.cargo
ENV CARGO_REGISTRY_CACHE_DIR=/tmp/.cargo/registry/cache
ENV CARGO_REGISTRY_INDEX_DIR=/tmp/.cargo/registry/index

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
ENV PATH="/tmp/.cargo/bin:${PATH}"

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD ["python", "bot.py"]
