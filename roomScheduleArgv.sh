#! /usr/bin/env bash

################################################################################
# Help                                                                         #
################################################################################
Help()
{
   # Display Help
   echo "Gives you information about given room's schedule."
   echo
   echo "Syntax: roomSchedule [-h|t|n]"
   echo "options:"
   echo "h     Prints this help."
   echo "t     Outputs in terminal."
   echo "n     Outputs in browser."
   echo
}
################################################################################


################################################################################
# Main program                                                                 #
################################################################################
# $1 is the first argument passed to the script (t or n)
# $2 is the first argument passed to the script (the room name)
room=$(curl -s https://www.hesge.ch/heg/salle/"$2" | pup ':contains("Salle") text{}')
################################################################################


################################################################################
# Process the input options. Add options as needed.                            #
################################################################################
# Get the options
while getopts "ht:n:" option; do
    case $option in
        h) # display Help
            Help   # Call Help function
            exit;;
        t) # Output in terminal
            if [ "$room" = "Salle occupée" ]; then # If the room is occupied then the text is red
                tput setaf 1; tput bold; curl -s https://www.hesge.ch/heg/salle/"$2" | pup ':contains("Salle") text{}'
            else # If the room is free then the text is green
                tput setaf 2; tput bold; curl -s https://www.hesge.ch/heg/salle/"$2" | pup ':contains("Salle") text{}'
            fi
            tput setaf 7; curl -s https://www.hesge.ch/heg/salle/"$2" | pup 'p text{}' # echo's the rest of the text in white
            exit;;
        n) # Output in browser
            open https://www.hesge.ch/heg/salle/"$2" 
            exit;;
        \?) # Incorrect option
            echo "Error: Invalid option" # If the option is not h, t or n then it's invalid
            exit;;
   esac
done
################################################################################