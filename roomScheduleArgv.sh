#! /usr/bin/env bash

choix=$1
# $1 is the first argument passed to the script (t or n)
# $2 is the first argument passed to the script (the room name)

if [ "$choix" = "-t" ]; then
    room=$(curl -s https://www.hesge.ch/heg/salle/"$2" | pup ':contains("Salle") text{}')
    if [ "$room" = "Salle occupée" ]; then
        tput setaf 1; tput bold; curl -s https://www.hesge.ch/heg/salle/"$2" | pup ':contains("Salle") text{}'
    else
        tput setaf 2; tput bold; curl -s https://www.hesge.ch/heg/salle/"$2" | pup ':contains("Salle") text{}'
    fi
    tput setaf 7; curl -s https://www.hesge.ch/heg/salle/"$2" | pup 'p text{}'
else
    open https://www.hesge.ch/heg/salle/"$2"
fi