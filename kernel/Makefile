.env:
	echo KVM_GID=$(shell getent group kvm | cut -d: -f3) > .env

build: .env
	docker compose build

up:
	docker compose up