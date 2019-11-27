FROM tomcat:7-jre8-alpine
MAINTAINER Adrian Pfleiderer <adrian.pfleiderer@student.uni-augsburg.de>

ARG XNAT_VER
ARG XNAT_ROOT=/data/xnat
ARG XNAT_HOME=/data/xnat/home
ARG XNAT_DATASOURCE_DRIVER=org.postgresql.Driver
ARG XNAT_DATASOURCE_URL=jdbc:postgresql://xnat-db/xnat
ARG XNAT_DATASOURCE_USERNAME=xnat
ARG XNAT_DATASOURCE_PASSWORD=xnat
ARG XNAT_HIBERNATE_DIALECT=org.hibernate.dialect.PostgreSQL9Dialect
ARG TOMCAT_XNAT_FOLDER=ROOT
ARG SMTP_ENABLED=false
ARG SMTP_HOSTNAME=fake.fake
ARG SMTP_PORT
ARG SMTP_AUTH
ARG SMTP_USERNAME
ARG SMTP_PASSWORD

ADD make-xnat-config.sh /usr/local/bin/make-xnat-config.sh
ADD wait-for-postgres.sh /usr/local/bin/wait-for-postgres.sh

RUN apk add --no-cache postgresql-client
RUN apk add --no-cache postgresql-client
RUN apk add --no-cache bash git openssh
RUN apk add --no-cache wget
RUN apk add --no-cache unzip
RUN apk add --no-cache gradle
RUN rm -rf $CATALINA_HOME/webapps/*
RUN mkdir -p $CATALINA_HOME/webapps/${TOMCAT_XNAT_FOLDER}
RUN mkdir -p ${XNAT_HOME}/config
RUN mkdir -p ${XNAT_HOME}/config/auth
RUN mkdir -p ${XNAT_HOME}/logs
RUN mkdir -p ${XNAT_HOME}/plugins
RUN mkdir -p ${XNAT_HOME}/work
RUN mkdir -p ${XNAT_ROOT}/archive
RUN mkdir -p ${XNAT_ROOT}/build
RUN mkdir -p ${XNAT_ROOT}/cache
RUN mkdir -p ${XNAT_ROOT}/ftp
RUN mkdir -p ${XNAT_ROOT}/pipeline
RUN mkdir -p ${XNAT_ROOT}/pipeline/temp
RUN mkdir -p ${XNAT_ROOT}/prearchive
RUN cd ${XNAT_HOME}/plugins
RUN wget https://bitbucket.org/icrimaginginformatics/ohif-viewer-xnat-plugin/downloads/ohif-viewer-plugin-2.0.0-bundle-XNAT-1.7.4.1.zip
RUN unzip -o ohif-viewer-plugin-2.0.0-bundle-XNAT-1.7.4.1.zip
RUN rm ohif-viewer-plugin-2.0.0-bundle-XNAT-1.7.4.1.zip
RUN wget https://bitbucket.org/xnatx/ldap-auth-plugin/downloads/xnat-ldap-auth-plugin-1.0.0.jar
RUN cd ${XNAT_ROOT}/pipeline
RUN git clone https://www.github.com/nrgXnat/xnat-pipeline-engine.git
RUN chmod +x /usr/local/bin/make-xnat-config.sh
RUN /usr/local/bin/make-xnat-config.sh
RUN rm /usr/local/bin/make-xnat-config.sh
RUN cd xnat-pipeline-engine
RUN ./gradlew
RUN cd $CATALINA_HOME/webapps/
RUN wget https://api.bitbucket.org/2.0/repositories/xnatdev/xnat-web/downloads/xnat-web-${XNAT_VER}.war
RUN cd ${TOMCAT_XNAT_FOLDER}
RUN unzip -o ../xnat-web-${XNAT_VER}.war
RUN rm -f ../xnat-web-${XNAT_VER}.war

EXPOSE 8080
ENV XNAT_HOME=${XNAT_HOME} XNAT_DATASOURCE_USERNAME=${XNAT_DATASOURCE_USERNAME} XNAT_ROOT=${XNAT_ROOT}

RUN chmod +x /usr/local/bin/wait-for-postgres.sh
CMD ["wait-for-postgres.sh", "/usr/local/tomcat/bin/catalina.sh", "run"]
