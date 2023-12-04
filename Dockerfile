FROM openjdk:17-alpine as builder
#RUN wget https://downloads.mysql.com/archives/get/p/3/file/mysql-connector-j-8.0.32.zip
#RUN mkdir /opt/app && cd /opt/app && wget https://downloads.mysql.com/archives/get/p/3/file/mysql-connector-j-8.0.32.zip 
#RUN unzip mysql-connector-j-8.0.32.zip mysql-connector-j-8.0.32/mysql-connector-j-8.0.32.jar  && mv mysql-connector-j-8.0.32/mysql-connector-j-8.0.32.jar target/mysql-connector-j-8.0.32.jar  && rm -Rf mysql-connector-j-8.0.32
RUN apk update && apk add --no-cache maven git
WORKDIR /opt/app
RUN cd /opt/app && git clone https://github.com/asilvame/AvaliacaoCloudMinsait 
#RUN cd /opt/app/AvaliacaoCloudMinsait && mvn clean dependency:copy-dependencies install -DskipTests && unzip ../mysql-connector-j-8.0.32.zip mysql-connector-j-8.0.32/mysql-connector-j-8.0.32.jar  && mv mysql-connector-j-8.0.32/mysql-connector-j-8.0.32.jar /opt/app/AvaliacaoCloudMinsait/target/mysql-connector-j-8.0.32.jar && rm -Rf mysql-connector-j-8.0.32
RUN cd /opt/app/AvaliacaoCloudMinsait && mvn clean dependency:copy-dependencies install -DskipTests 
#&& unzip ../mysql-connector-j-8.0.32.zip mysql-connector-j-8.0.32/mysql-connector-j-8.0.32.jar  && mv mysql-connector-j-8.0.32/mysql-connector-j-8.0.32.jar /opt/app/AvaliacaoCloudMinsait/target/mysql-connector-j-8.0.32.jar && rm -Rf mysql-connector-j-8.0.32
RUN cp /opt/app/AvaliacaoCloudMinsait/target/dependency/* /opt/app/.
#RUN cp /opt/app/AvaliacaoCloudMinsait/target/minsait-0.0.1-SNAPSHOT.jar /opt/app/minsait-app.jar
#COPY run-app.sh /opt/app/run-app.sh
#CMD ["sh"]
#EXPOSE 8080
#CMD ["sh", "/opt/app/run-app.sh"]

#ENTRYPOINT ["sh", "/opt/app/run-app.sh"]
#FROM openjdk:17.0.2-jdk
#WORKDIR /root/
##RUN mkdir ReportPath
#COPY --from=builder /opt/app/AvaliacaoCloudMinsait/target/*.jar .
#EXPOSE 8080
#CMD ["java","-jar","/root/minsait-0.0.1-SNAPSHOT.jar"]
# Add app user
FROM openjdk:17-alpine

ARG APPLICATION_USER=appuser
RUN adduser --no-create-home -u 1000 -D $APPLICATION_USER

# Configure working directory
RUN mkdir /app && \
    chown -R $APPLICATION_USER /app

USER 1000

COPY --chown=1000:1000 --from=builder /opt/app/AvaliacaoCloudMinsait/target/minsait-0.0.1-SNAPSHOT.jar  /app/app.jar
COPY --chown=1000:1000 --from=builder /opt/app/*.jar /app/.
WORKDIR /app

EXPOSE 8080
ENTRYPOINT [ "java", "-jar", "/app/app.jar" ]