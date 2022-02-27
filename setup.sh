docker network create jenkins || true && \
docker build -t jenkins . && \
docker run --name dind --rm -d --privileged --network jenkins --network-alias docker -e DOCKER_TLS_CERTDIR=/certs -v dind-certs:/certs/client -v jenkins:/var/jenkins_home -p 2376:2376 docker:dind --storage-driver overlay2  || true && \
docker run --rm -d --name sonarqube --network jenkins -v sonar:/opt/sonarqube/data -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true -p 9000:9000 sonarqube:latest || true  && \
docker run --name jenkins --rm --network jenkins -e DOCKER_HOST=tcp://docker:2376 -e DOCKER_CERT_PATH=/certs/client -e DOCKER_TLS_VERIFY=1 -p 8080:8080 -p 50000:50000 -v jenkins:/var/jenkins_home -v dind-certs:/certs/client:ro jenkins || true 
