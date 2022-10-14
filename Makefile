

frontend_dir=frontend
git_prefix=git@github.com:smswithoutborders
git_branch=staging

all: config clone

config:
	@echo "[!] Creating env configs"
	@cp env.example .env

clone:
	@echo "[!] Cloning repos"
	@test -d $(frontend_dir) || git clone --branch dev --single-branch $(git_prefix)/smswithoutborders.com.git $(frontend_dir)

clean:
	@echo "[!] Removing all repos"
	rm -rf $(frontend_dir)