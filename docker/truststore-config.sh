#!/bin/bash


#Downloads all certs from vault
#This wil be saved in /etc/sds/sparta/security/truststore.jks
#The password for the keystore is saved to $DEFAULT_KEYSTORE_PASS
_log_sparta_sec "Getting accepted certs from vault"
export SECURITY_STORE_PATH="/etc/sds/sparta/security"
export TRUSTSTORE_NAME="truststore.jks"
getCAbundle "$SECURITY_STORE_PATH" JKS "$TRUSTSTORE_NAME"

export TRUSTSTORE_PATH="$SECURITY_STORE_PATH/$TRUSTSTORE_NAME"

#Add all certs from the truststore to the java truststore
#TODO Vault: availability for default truststore for java
export JVMCA_PASS="changeit"
_log_sparta_sec "Adding certs to java trust store"
keytool -importkeystore -srckeystore "$TRUSTSTORE_PATH" -destkeystore $JAVA_HOME/jre/lib/security/cacerts \
    -srcstorepass "$DEFAULT_KEYSTORE_PASS" -deststorepass "$JVMCA_PASS" -noprompt

