# shared git params
git_prefix=git@github.com:smswithoutborders
git_branch=staging

# folders
frontend_dir=frontend
backend_dir=backend
platforms_dir=platforms


all: config clone

config:
	@echo "[!] Creating env configs ..."
	@cp env.example .env
	@echo "[!] Configs created edit them to suit your needs, then build and deploy"

clone:
	@echo "[!] Cloning repos ..."
	@test -d $(frontend_dir) || git clone --branch dev --single-branch $(git_prefix)/smswithoutborders.com.git $(frontend_dir)
	@test -d $(backend_dir) || git clone --branch $(git_branch) --single-branch $(git_prefix)/SMSwithoutborders-BE.git $(backend_dir)
	@test -d $(platforms_dir)/gmail || git clone --branch $(git_branch) --single-branch $(git_prefix)/SMSwithoutBorders-customplatform-Gmail.git $(platforms_dir)/gmail
	@test -d $(platforms_dir)/twitter || git clone --branch $(git_branch) --single-branch $(git_prefix)/SMSwithoutBorders-customplatform-Twitter.git $(platforms_dir)/twitter
	@test -d $(platforms_dir)/telegram || git clone --branch $(git_branch) --single-branch $(git_prefix)/SMSWithoutBorders-customplatform-Telegram.git $(platforms_dir)/telegram
	@test -d $(platforms_dir)/slack || git clone --branch $(git_branch) --single-branch $(git_prefix)/SMSWithoutBorders-customplatform-Slack.git $(platforms_dir)/slack

build:
	@echo "[!] Building container smswithoutborders ..."
	@docker-compose build

start:
	@echo "[!] Starting smswithoutborders ..."
	@docker-compose up -d

stop:
	@echo "[!] Stopping smswithoutborders ..."
	@docker-compose down

clean:
	@echo "[!] Removing all repos ..."
	rm -rf $(frontend_dir) $(backend_dir) $(platforms_dir)