#!/bin/bash
cd `dirname $0`
app_name=`pwd | awk -F '/' '{print $NF}'`
dockerfile_name=`grep WORKDIR Dockerfile | cut -d '/' -f 3 | tr -d '\r'`
dockerfile_port=`grep EXPOSE Dockerfile | cut -d ' ' -f 2 | tr -d '\r'`
cd *SNAPSHOT
app_port=`sed '/dubbo.protocol.port/!d;s/.*=//' META-INF/conf.properties | tr -d '\r'`

echo $app_name
echo $app_port

case $1 in
  "build")
    \cp -f META-INF/log4j-online.properties META-INF/log4j.properties
    #sed -i "s#log4j.appender.dailyFile.Threshold=.*#log4j.appender.dailyFile.Threshold=INFO#g" META-INF/log4j.properties
    sed -i "s#log4j.appender.dailyFile.File=.*#log4j.appender.dailyFile.File=\/opt\/logs\/${app_name}\/log.log4j#g" META-INF/log4j.properties
    \cp -f bin/512_start.sh bin/start.sh
    sed -i '/nohup/s/&$//;s/nohup //' bin/start.sh
    sed -i '/^java/s/> $STDOUT_FILE 2>&1//g' bin/start.sh
    cd ..
    sed -i "s/$dockerfile_name/$app_name/g" Dockerfile
    sed -i "s/$dockerfile_port/$app_port/g" Dockerfile
    docker build -t $app_name .
  ;;
  *)
    echo "Usage: Please input build"
  ;;
esac
