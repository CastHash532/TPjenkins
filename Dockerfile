FROM jenkins/jenkins:2.319.2-jdk11
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.2 cucumber-reports:5.6.1 sonar:2.14 slack:2.49"