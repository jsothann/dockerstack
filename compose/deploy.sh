#!/bin/bash

for enreg in `cat ~/docker.csv`
do

    # Lit le CSV et récupére les informations

    USER=`echo $enreg | awk -F"," '{ print $1 }'`
    PASSWORD=`echo $enreg | awk -F"," '{ print $2 }'`
    PORTS=`echo $enreg | awk -F"," '{ print $3 }'`

	#echo "$USER - $PASSWORD - $PORTS"
	echo -e "\033[31m[$PORTS | Déploiement en cours...]\033[0m" 

                # Vérifie si l'utilisateur existe

		egrep -i "^$USER:" /etc/passwd;
		if [ $? -eq 0 ]; then

   			echo -e "\033[31m[!!! ATTENTION !!!]\033[0m"
			sleep 1
			echo -e "\033[31m| --> L'utilisateur $USER existe déjà ! Pour arrêter le déploiement : CTRL + Z. \033[0m"
			sleep 1
			echo -e "\033[34m| --> Reprise automatique dans 10 secondes... \033[0m"
			sleep 10
		else

                # Créé les utilisateurs et attribue un password

		useradd -p $(openssl passwd -1 $PASSWORD) $USER
		echo -e "\033[32m[++]\033[0m Utilisateur $USER ajouté."

                # Créé les dossiers de l'utilisateurs

                mkdir ./users/$USER
                mkdir ./users/$USER/conf.d
                mkdir ./users/$USER/html
		echo -e "\033[32m[++]\033[0m $USER : Dossier créé."

		# Personnalisation des fichier nginx + PHP-FPM

		sed "s/TOCHANGE/${USER}_php:9000/" ./users/default/conf.d/nginx.conf > /tmp/nginx.conf
		mv /tmp/nginx.conf ./users/$USER/conf.d/nginx.conf

                # Copie les fichiers "default" dans le répertoire utilisateur

                #sudo cp -r ./users/default/conf.d/ ./users/$USER/
                cp -r ./users/default/html/ ./users/$USER/

		# Personnalisation des index

		sed "s/YYY/${USER}/" ./users/default/html/80/tmp.php > /tmp/index.php
		sed "s/PASSWORD/$PASSWORD/" /tmp/index.php > /tmp/index.php2
		sed "s/PORT/1000${PORTS}/" /tmp/index.php2 > /tmp/index.php3
		sed "s/ip_port/172.17.0.1:1000${PORTS}/" /tmp/index.php3 > /tmp/index.php4
		sed "s/php_container/${USER}_php_1:9000/" /tmp/index.php4 > /tmp/index.php5
		sed "s/http_user/800${PORTS}/" /tmp/index.php5 > /tmp/index.php6
		sed "s/phpmyadmin_user/300${PORTS}/" /tmp/index.php6 > /tmp/index.php7
		sed "s/vhost_user/900${PORTS}/" /tmp/index.php7 > /tmp/index.php8
		sed "s/varnish_user/1100${PORTS}/" /tmp/index.php8 > /tmp/index.php9
		mv /tmp/index.php9 ./users/$USER/html/80/index.php
		sed "s/YYY/${USER}/" ./users/default/html/8080/tmp.html > /tmp/index.html 
		mv /tmp/index.html ./users/$USER/html/8080/index.html

		# Suppression des index temporaires

		rm ./users/$USER/html/80/tmp*
		rm ./users/$USER/html/8080/tmp*

                # Attribue les droits nécessaires aux répertoires en question

                chown $USER -R users/$USER
                chmod 770 -R users/$USER
                chmod a+r -R users/$USER
                chmod a+x -R users/$USER
		echo -e "\033[32m[++]\033[0m $USER : Fichiers par défault copiés, droits d'accès modifiés."

                # Vérifie la présence des utilisateurs

                echo -e "\033[32m[++]\033[0m $USER : Extrait du /etc/group :"
                cat /etc/group | grep $USER

                # Reconfigure le docker-compose

                sed "s/NGPORT/800$PORTS/" docker-compose.yml > /tmp/compose.yml
                sed "s/NGPORS/900$PORTS/" /tmp/compose.yml > /tmp/compose2.yml
                sed "s/DBPORT/1000$PORTS/" /tmp/compose2.yml > /tmp/compose3.yml
                sed "s/PHMPORT/300$PORTS/" /tmp/compose3.yml > /tmp/compose4.yml
		sed "s/default/$USER/" /tmp/compose4.yml > /tmp/compose5.yml
                sed "s/PASSWD/$PASSWORD/" /tmp/compose5.yml > /tmp/compose6.yml
		sed "s/XXX/BACKEND_PORT_800${PORTS}_TCP_ADDR/" /tmp/compose6.yml > /tmp/compose7.yml
		sed "s/ZZZ/800$PORTS/" /tmp/compose7.yml > /tmp/compose8.yml
		sed "s/VHPORT/1100$PORTS/" /tmp/compose8.yml > /tmp/compose9.yml
		#sed "s/AAA/1200$PORTS/" /tmp/compose9.yml > /tmp/compose10.yml
		sed "s/database/$USER/" /tmp/compose10.yml > users/$USER/docker-compose.yml
		echo -e "\033[34m[++]\033[0m DOCKER : Dockercompose.yml modifié." 

		# Créé le fichier listing

		jour=$(date +%Y%m%d)
		touch admin/listing-$jour.txt
		echo "[XXXXXXXX] UTILISATEUR : $USER" >> admin/listing-$jour.txt
                echo "[PWD] $PASSWORD" >> admin/listing-$jour.txt
		echo "[HTTP] 800$PORTS & 900$PORTS" >> admin/listing-$jour.txt
		echo "[DB] 1000$PORTS" >> admin/listing-$jour.txt
		echo "[PHPMYADMIN] 300$PORTS" >> admin/listing-$jour.txt
		echo "[VARNISH] 1100$PORTS" >> admin/listing-$jour.txt
                echo -e "\033[34m[++]\033[0m DOCKER : Fichier ~/admin/listing-$jour.txt implémenté."

                # Execute le docker compose

                cd users/$USER/
                echo -e "\033[34m[++]\033[0m DOCKER :Création du Stack Web veuillez patienter..."
                docker-compose up -d
                echo -e "\033[34m[++]\033[0m DOCKER : Stack WEB créé."
		cd ../../

		# Copie le docker-compose.yml de l'étudiant

		mv users/$USER/docker-compose.yml admin/yml/$USER.yml
                echo -e "\033[34m[++]\033[0m DOCKER : Dossier ~/admin/yml/ implémenté."
		rm /tmp/compose*
		rm /tmp/index*
		fi
done
