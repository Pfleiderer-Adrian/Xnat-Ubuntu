#!/bin/sh

# generate xnat config
if [ ! -f $XNAT_HOME/config/xnat-conf.properties ]; then
  cat > $XNAT_HOME/config/xnat-conf.properties << EOF
datasource.driver=$XNAT_DATASOURCE_DRIVER
datasource.url=$XNAT_DATASOURCE_URL
datasource.username=$XNAT_DATASOURCE_USERNAME
datasource.password=$XNAT_DATASOURCE_PASSWORD
hibernate.dialect=$XNAT_HIBERNATE_DIALECT
hibernate.hbm2ddl.auto=update
hibernate.show_sql=false
hibernate.cache.use_second_level_cache=true
hibernate.cache.use_query_cache=true
EOF
fi

if [ ! -f $XNAT_ROOT/pipeline/xnat-pipeline-engine/gradle.properties ]; then
  cat > $XNAT_ROOT/pipeline/xnat-pipeline-engine/gradle.properties << EOF
xnatUrl=http://oldschool.edu
siteName=XNAT
adminEmail=admin@oldschool.edu
smtpServer=mail.oldschool.edu
destination=/data/xnat/pipeline
EOF
fi

if [ ! -f $XNAT_HOME/config/auth/ldap-provider.properties ]; then
  cat > $XNAT_HOME/config/auth/ldap-provider.properties << EOF
name=LDAP
provider.id=ldap
auth.method=ldap
address=ldap://sample.sample.de/dc=uni-augsburg,dc=de
userdn=cn=UNI-AUGSBURG\\mustermann,dc=uni-augsburg,dc=de
password=
search.base=
search.filter=(sAMAccountName=mustermann)
EOF
fi

if [ ! -f $XNAT_HOME/config/auth/local-provider.properties ]; then
  cat > $XNAT_HOME/config/auth/local-provider.properties << EOF
provider.db.name=LOCAL
provider.db.id=localdb
provider.db.type=db
EOF
fi

if [ ! -f $XNAT_HOME/config/prefs-init.ini ]; then
  cat > $XNAT_HOME/config/prefs-init.ini << EOF
[siteConfig]

siteId=XNAT
siteUrl=http://localhost
adminEmail=fake@fake.fake

archivePath=/data/xnat/archive
prearchivePath=/data/xnat/prearchive
cachePath=/data/xnat/cache
buildPath=/data/xnat/build
ftpPath=/data/xnat/ftp
pipelinePath=/data/xnat/pipeline

requireLogin=true
userRegistration=false
enableCsrfToken=true
sessionTimeout=1 hour
initialized=false

[notifications]

smtpEnabled=${SMTP_ENABLED}
smtpHostname=${SMTP_HOSTNAME}
smtpPort=${SMTP_PORT}
smtpProtocol=${SMTP_PROTOCOL}
smtpAuth=${SMTP_AUTH}
smtpUsername=${SMTP_USERNAME}
smtpPassword=${SMTP_PASSWORD}
smtpStartTls=false
smtpSslTrust=
emailPrefix=XNAT

EOF
fi

