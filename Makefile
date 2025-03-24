VERSION=v1
DOCKERUSER=dharinidhba

build:
	docker build -f Dockerfile -t demucs-clone .
push:
	docker tag demucs-clone $(DOCKERUSER)/demucs-clone:$(VERSION)
	docker push $(DOCKERUSER)/demucs-clone:$(VERSION)
	docker tag demucs-clone $(DOCKERUSER)/demucs-clone:latest
	docker push $(DOCKERUSER)/demucs-clone:latest
