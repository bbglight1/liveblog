DEPLOYMENT = ~/deployment
TARGET = liveblog
METEOR = /usr/local/bin/meteor

DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m
DONE="\n${CHECK} Done.\n"

bundle:
	@echo "\n\nBundling the project..."
	@rm -rf ${TARGET}.tgz
	${METEOR} bundle ${TARGET}.tgz
	@echo ${DONE}

deploy: bundle
	@echo "\n\nDeploying the project..."
	@mv $(TARGET).tgz $(DEPLOYMENT)
	@cd $(DEPLOYMENT); \
	tar zxvf $(TARGET).tgz; \
	mv bundle livelog
	@sudo supervisorctl restart liveblog
	@echo ${DONE}
