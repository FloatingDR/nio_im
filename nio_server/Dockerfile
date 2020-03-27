FROM java:8-jre
MAINTAINER taylor <3520745329@qq.com>

RUN echo "Asia/Shanghai" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

ARG APP_NAME="nio_server"

COPY target/$APP_NAME-*.jar app.jar

ENV JAVA_OPTS="-Xms512m -Xmx1024m"
ENV PARAMS=""
EXPOSE 8080

ENTRYPOINT exec java -server $JAVA_OPTS -jar /app.jar $PARAMS