#! /usr/bin/env bash

echo -n "Afficher dans le terminal (t) ou dans le navigateur (n) ? "; read choix
echo -n "Choisir la salle: "; read salleNom

if [ $choix = "t" ]; then
    curl -s https://www.hesge.ch/heg/salle/$salleNom | pup -c ':contains("Horaire"), p, :contains("Salle") text{}'
else
    open https://www.hesge.ch/heg/salle/$salleNom
fi