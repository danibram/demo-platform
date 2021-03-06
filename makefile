.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init: ## Prepare platform
	@echo "Cloning Access Platform"
	@git clone https://github.com/AllironRentals/control-access-simulator.git ./services/access-control
	@echo 'FROM node:13-alpine\nADD package.json /tmp/package.json\nADD package-lock.json /tmp/package-lock.json\nRUN cd /tmp && npm ci\nRUN mkdir -p /app\nRUN cp -a /tmp/node_modules /app/\n\nWORKDIR /app\n\nEXPOSE 3001\n\nCMD ["npm", "start"]' >> ./services/access-control/Dockerfile
	@git clone https://github.com/danibram/demo-booking.git ./services/booking


dev: ## Start Dev platform
	@echo "Starting Dev Platform"
	@docker-compose up --build -d
	@make dev-logs

dev-rebuild: ## Forcing to remove docker cache
	@docker-compose build --no-cache --force-rm
	@docker-compose up -d

dev-stop: ## Stop dev env
	@docker-compose down

dev-rm: ## Remove everything from dev env
	@docker-compose down -v --rmi all --remove-orphans

dev-logs: ## Output logs from access-control booking
	@docker-compose logs -f access-control booking