NAME = inbrief
REMOTE_NAME = johnjones4/${NAME}

build:
	docker build -t ${NAME} ./
	docker tag ${NAME} ${REMOTE_NAME}
	docker push ${REMOTE_NAME}

deploy: build
	ssh ${NAME} "docker stop ${NAME} && docker rm ${NAME} && docker pull johnjones4/inbrief && docker run -d -v /home/ubuntu/config:/config -e CONFIG=/config/config.json -e PORT=80 -p 80:80 --name ${NAME} ${REMOTE_NAME}"
