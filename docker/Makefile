build:
	docker compose build

start:
	docker compose up -d && docker compose logs -f --tail=100

clear:
	docker compose down && docker volume prune

setup_and_start: build start