
REPOS=repos
CONFIGS=configs

FRONT-END=front-end
BACK-END=back-end
GATEWAY-SERVER=gateway-server
PUBLISHER=publisher

make: clean staging

deps:
	@mkdir -p ${REPOS}
	@mkdir -p ${CONFIGS}

clone: deps
	@git clone https://github.com/smswithoutborders/smswithoutborders.com.git ${REPOS}/${FRONT-END}
	@git clone https://github.com/smswithoutborders/SMSwithoutborders-BE.git ${REPOS}/${BACK-END}
	@git clone https://github.com/smswithoutborders/SMSWithoutBorders-Gateway-Server.git \
		${REPOS}/${GATEWAY-SERVER}
	@git clone https://github.com/smswithoutborders/SMSWithoutBorders-Publisher.git ${REPOS}/${PUBLISHER}

staging: clone
	@git -C ${REPOS}/${FRONT-END} checkout staging
	@git -C ${REPOS}/${BACK-END} checkout staging
	# @git -C ${REPOS}/${GATEWAY-SERVER} checkout staging
	# @git -C ${REPOS}/${PUBLISHER} checkout staging

clean:
	@docker image rm swob_infra_front-end -f
	@docker image rm swob_infra_back-end -f
	@docker container rm swob_infra_front-end_1 -f
	@docker container rm swob_infra_back-end_1 -f
	@docker container prune
	@docker image prune -a
	@docker volume prune
	@rm -r ${REPOS}
	@rm -r ${CONFIGS}

update:
	@git -C ${REPOS}/${FRONT-END} pull -r origin staging
	@git -C ${REPOS}/${BACK-END} pull -r origin staging
	# @git -C ${REPOS}/${GATEWAY-SERVER} pull origin staging
	# @git -C ${REPOS}/${PUBLISHER} pull origin staging

fuckit:
	docker rm -vf $(docker ps -aq)
	docker rmi -f $(docker images -aq)
	docker system prune -a --volumes
