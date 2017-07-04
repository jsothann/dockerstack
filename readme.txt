|-----------------------------------------------------------------------|
|			    PROJET DOCKER				|
|-----------------------------------------------------------------------|

- Utilisation : 

	1 - Créez un fichier .csv (séparé par des virgules) et ajoutez
	    le au sein du répertoire : /home/dockeradmin.
	
	2 - Executez le script : ./deploy.sh


- Arborescence : 

	/home/dockeradmin/docker.csv (USER,MOTDEPASSE,NUMERO)

	/home/dockeradmin/compose
		|
		|- Admin (dossier administrateur)
		|   |
		|   |- listing.txt (fichier récaputilant les users/motsdepasse/ports)
		|   |- yml (dossier contenant les docker-compose lancés)
		|   |	|
		|   |	|- user1.yml
		|   |	|- user2.yml
		|
		|- DB (dossier contenant la base de données MARIADB des utilisateurs)
		|   |
		|   |- user1
		|   |- user2
		|
		|- deploy.sh (script d'automatisation)
		|- docker-compose.yml (docker-compose par défaut)
		|
		|- users (dossier de la configuration apache des utilisateurs)
		|   |
		|   |- user1
		|   |    |- conf.d
	        |   |    |- html
 		|   |



- Suppresion d'un stack web

Lors de la suppresion d'un stack web, veuillez effectuer les actions suivantes :
	
	1 - Effectuez la commande : docker ps afin de visualiser les stack en
	    en production. Reperez les containers possédant l'identifiant
            de l'étudiant.

	2 - Arretez les containers : docker container kill.

	3 - Veuillez à bien supprimer l'utilisateur : sudo userdel $user ainsi 
	    que dans les dossiers suivant :
		- ~/compose/DB/$user
		- ~/compose/users/$user


- Troobleshooting

[X] ERROR: client and server don't have same version (client : 1.21, server: 1.18)
export COMPOSE_API_VERSION=1.18

[X] Arreter tous les container
docker stop $(docker ps -a -q)

[X] Supprimer tous les images
docker rm $(docker ps -a -q)
