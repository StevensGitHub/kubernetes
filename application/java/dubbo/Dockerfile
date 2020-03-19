FROM registry-vpc.cn-shanghai.aliyuncs.com/jiadx/apps:openjdk-8-v3 
MAINTAINER steven
WORKDIR /opt/bus-api
ADD *SNAPSHOT ./ 
ENV JAVA_OPTS="-Duser.timezone=Asia/Shanghai"
EXPOSE 6604 
ENTRYPOINT exec ./bin/start.sh
