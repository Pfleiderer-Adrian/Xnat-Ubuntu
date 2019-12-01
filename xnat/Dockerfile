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

RUN	apk add --no-cache postgresql-client && \
	apk add --no-cache postgresql-client && \
	apk add --no-cache bash git openssh && \
	apk add --no-cache wget && \
	apk add --no-cache unzip && \
	apk add --no-cache gradle && \
	rm -rf $CATALINA_HOME/webapps/* && \
	mkdir -p $CATALINA_HOME/webapps/${TOMCAT_XNAT_FOLDER} && \
	mkdir -p ${XNAT_HOME}/config/auth && \
	mkdir -p ${XNAT_HOME}/logs && \
	mkdir -p ${XNAT_HOME}/plugins && \
	mkdir -p ${XNAT_HOME}/work && \
	mkdir -p ${XNAT_ROOT}/archive && \
	mkdir -p ${XNAT_ROOT}/build && \
	mkdir -p ${XNAT_ROOT}/cache && \
	mkdir -p ${XNAT_ROOT}/ftp && \
	mkdir -p ${XNAT_ROOT}/pipeline/temp && \ 
	mkdir -p ${XNAT_ROOT}/prearchive && \
	cd ${XNAT_HOME}/plugins && \
	wget https://bitbucket.org/icrimaginginformatics/ohif-viewer-xnat-plugin/downloads/ohif-viewer-plugin-2.0.0-bundle-XNAT-1.7.4.1.zip && \
	unzip -o ohif-viewer-plugin-2.0.0-bundle-XNAT-1.7.4.1.zip && \
	rm ohif-viewer-plugin-2.0.0-bundle-XNAT-1.7.4.1.zip && \
	wget https://bitbucket.org/xnatx/ldap-auth-plugin/downloads/xnat-ldap-auth-plugin-1.0.0.jar && \
	cd ${XNAT_ROOT}/pipeline && \
	git clone https://www.github.com/nrgXnat/xnat-pipeline-engine.git && \
	pwd && \
	ls && \
	chmod +x /usr/local/bin/make-xnat-config.sh && \
	/usr/local/bin/make-xnat-config.sh && \
	rm /usr/local/bin/make-xnat-config.sh && \
	cd ${XNAT_ROOT}/pipeline/xnat-pipeline-engine && \
	pwd && \
	ls && \
	./gradlew && \
	cd $CATALINA_HOME/webapps/ && \
	wget https://api.bitbucket.org/2.0/repositories/xnatdev/xnat-web/downloads/xnat-web-${XNAT_VER}.war && \
	cd ${TOMCAT_XNAT_FOLDER} && \
	unzip -o ../xnat-web-${XNAT_VER}.war &&\
	rm -f ../xnat-web-${XNAT_VER}.war

EXPOSE 8080
ENV XNAT_HOME=${XNAT_HOME} XNAT_DATASOURCE_USERNAME=${XNAT_DATASOURCE_USERNAME} XNAT_ROOT=${XNAT_ROOT}
VOLUME /data/xnat
RUN chmod +x /usr/local/bin/wait-for-postgres.sh
CMD ["wait-for-postgres.sh", "/usr/local/tomcat/bin/catalina.sh", "run"]
