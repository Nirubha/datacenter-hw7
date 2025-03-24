# Base image supports Nvidia CUDA but does not require it and can also run demucs on the CPU
FROM nvidia/cuda:11.8.0-base-ubuntu22.04

USER root
ENV TORCH_HOME=/data/models

# Install required tools
# Notes:
#  - build-essential and python3-dev are included for platforms that may need to build some Python packages (e.g., arm64)
#  - torchaudio >= 0.12 now requires ffmpeg on Linux, see https://github.com/facebookresearch/demucs/blob/main/docs/linux.md
RUN apt update && apt install -y --no-install-recommends \
    build-essential \
    ffmpeg \
    git \
    python3 \
    python3-dev \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Clone Facebook Demucs
RUN git clone -b main --single-branch https://github.com/facebookresearch/demucs /lib/demucs
WORKDIR /lib/demucs

# Install dependencies
RUN python3 -m pip install -e . --no-cache-dir
RUN pip3 install torch==1.13.1 torchvision==0.14.1 torchaudio==0.13.1 --extra-index-url https://download.pytorch.org/whl/cpu
# Run once to ensure demucs works and trigger the default model download
RUN python3 -m demucs -d cpu test.mp3
# Cleanup output - we just used this to download the model
RUN rm -r separated

VOLUME /data/input
VOLUME /data/output
VOLUME /data/models

ENTRYPOINT ["/bin/bash", "--login", "-c"]