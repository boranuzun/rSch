#! /usr/bin/env bash

echo -n "Afficher dans le terminal (t) ou dans le navigateur (n) ? "; read -r choix

if [ "$choix" = "t" ]; then
    curl -s https://www.hesge.ch/heg/salle/"$1" | pup 'p text{}'
    room=$(curl -s https://www.hesge.ch/heg/salle/"$1" | pup ':contains("Salle") text{}')

    if [ "$room" = "Salle occupée" ]; then
        tput setaf 1; tput bold; curl -s https://www.hesge.ch/heg/salle/"$1" | pup ':contains("Salle") text{}'
    else
        tput setaf 2; tput bold; curl -s https://www.hesge.ch/heg/salle/"$1" | pup ':contains("Salle") text{}'
    fi
else
    open https://www.hesge.ch/heg/salle/"$1"
fi