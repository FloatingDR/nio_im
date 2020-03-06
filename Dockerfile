FROM openjdk:8-jdk-alpine
VOLUME /tmp
ADD nio_im.war nio_im.war
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-war","/nio_im.war"]