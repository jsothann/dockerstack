#!/bin/bash

echo "Vous êtes sur le point de supprimer tous les containers.Etes-vous sûr de vouloir continuer (Y or N) ?"
read answer

if [[ $answer = Y ]]; then

	docker stop $(docker ps -a -q)
	docker rm $(docker ps -a -q)
fi


