FROM dharinidhba/demucs-clone:latest
#FROM xserrat/facebook-demucscd cd :latest
WORKDIR /app

RUN pip3 install requests minio redis ffmpeg

#RUN pip3 install torch==1.13.1 torchvision==0.14.1 torchaudio==0.13.1 --extra-index-url https://download.pytorch.org/whl/cpu

COPY worker.py /app

ENV PYTHONUNBUFFERED=1
# CMD [ "python3", "worker.py"]
ENTRYPOINT ["python3", "worker.py"]