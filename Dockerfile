FROM python:3.13-slim
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        pkg-config \
        libsystemd-dev \
        build-essential \
        curl \
        bsdmainutils \
        openssl \
        ssl-cert \
        ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN pip install systemd-socketserver regex --no-cache-dir --break-system-packages
WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1

CMD ["bash", "-c", "cd cert_gen && (python alpn-responder.py --bind &) && dehydrated/dehydrated --register --accept-terms && dehydrated/dehydrated -c"]
