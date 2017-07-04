#!/bin/bash

echo -e "\033[31m[SHIPYARD | Déploiement en cours...]\033[0m"
curl -sSL https://shipyard-project.com/deploy | bash -s
echo -e "\033[34m[++]\033[0m SHIPYARD : Lancé. Vous pouvez y accéder depuis portal.kryptonite.tech:8080."
