#!/bin/bash

if [ "$SHOW_JENKINS_PASSWORD" == 1 ]; then

    COUNT=1
    MAX_ATTEMPTS=30
    FILE_LOCATION=/var/lib/jenkins/secrets/initialAdminPassword

    RED='\033[0;31m'
    NC='\033[0m'

    while : ; do

        if [ ${COUNT} -gt ${MAX_ATTEMPTS} ]; then
            echo "Sorry. File is unable. Try to get a password manually"
            break
        fi

        if [ -f ${FILE_LOCATION} ]; then
            echo -e "Jenkins password: ${RED}$(cat ${FILE_LOCATION})${NC}"
            break
        fi

        COUNT=$((COUNT+1))
        sleep 1s;

    done

fi

rm /tmp/jenkins_password.sh