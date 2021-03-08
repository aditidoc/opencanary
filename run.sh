#! /bin/bash

CONF="/home/ferraglia-ftp/opencanary.conf"
TEMP_CONF="/root/.opencanary.conf"


defaultconf=$(python -c "from __future__ import print_function; from pkg_resources import resource_filename; print(resource_filename('opencanary', 'data/settings.json'))")
# il pvc con la configurazione Ã¨ sotto /home/ferraglia-ftp, qui ci devo anche confiurare i logs. 
# se il file esiste lo copio sotto la directory di lavoro e faccio partire il processo
# altrimenti lo creo da quello di default e lo copio, eventualente andrÃ  editato
if [ -f $CONF ]; then
	echo "INFO: Main configuration file found"
        mkdir /etc/opencanaryd
        cp "${CONF}" /etc/opencanaryd/opencanary.conf
        twistd -y /usr/local/bin/opencanary.tac
else
        mkdir /etc/opencanaryd
	cp "${defaultconf}" /etc/opencanaryd/opencanary.conf
        cp "${defaultconf}" "${CONF}"
        twistd -y /usr/local/bin/opencanary.tac
fi


