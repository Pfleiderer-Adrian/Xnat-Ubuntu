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
RUN [“chmod”, “+x”, "/usr/local/bin/make-xnat-config.sh"]

RUN apk add --no-cache \
        postgresql-client \
		bash git openssh \
        wget \
		unzip \
		chmod \
    && \
    rm -rf $CATALINA_HOME/webapps/* && \
    mkdir -p \
        $CATALINA_HOME/webapps/${TOMCAT_XNAT_FOLDER} \
        ${XNAT_HOME}/config \
		${XNAT_HOME}/config/auth \
        ${XNAT_HOME}/logs \
        ${XNAT_HOME}/plugins \
        ${XNAT_HOME}/work \
        ${XNAT_ROOT}/archive \
        ${XNAT_ROOT}/build \
        ${XNAT_ROOT}/cache \
        ${XNAT_ROOT}/ftp \
        ${XNAT_ROOT}/pipeline \
		${XNAT_ROOT}/pipeline/temp \
        ${XNAT_ROOT}/prearchive \
    && \
    /usr/local/bin/make-xnat-config.sh && \
    rm /usr/local/bin/make-xnat-config.sh && \
	cd ${XNAT_HOME}/plugins && \
	wget https://bitbucket.org/icrimaginginformatics/ohif-viewer-xnat-plugin/downloads/ohif-viewer-plugin-2.0.0-bundle-XNAT-1.7.4.1.zip && \
	unzip -o ohif-viewer-plugin-2.0.0-bundle-XNAT-1.7.4.1.zip && \
	rm ohif-viewer-plugin-2.0.0-bundle-XNAT-1.7.4.1.zip && \
	wget https://bitbucket.org/xnatx/ldap-auth-plugin/downloads/xnat-ldap-auth-plugin-1.0.0.jar && \
	cd ${XNAT_ROOT}/pipeline/temp && \
	git clone https://www.github.com/nrgXnat/xnat-pipeline-engine.git && \
    cd $CATALINA_HOME/webapps/ && \
    wget https://api.bitbucket.org/2.0/repositories/xnatdev/xnat-web/downloads/xnat-web-${XNAT_VER}.war && \
    cd ${TOMCAT_XNAT_FOLDER} && \
    unzip -o ../xnat-web-${XNAT_VER}.war && \
    rm -f ../xnat-web-${XNAT_VER}.war && \
    apk del wget

EXPOSE 8080
ENV XNAT_HOME=${XNAT_HOME} XNAT_DATASOURCE_USERNAME=${XNAT_DATASOURCE_USERNAME} XNAT_ROOT=${XNAT_ROOT}

RUN [“chmod”, “+x”, "wait-for-postgres.sh"]
CMD ["wait-for-postgres.sh", "/usr/local/tomcat/bin/catalina.sh", "run"]
RUN cd ${XNAT_ROOT}/pipeline/temp
RUN ./gradlew