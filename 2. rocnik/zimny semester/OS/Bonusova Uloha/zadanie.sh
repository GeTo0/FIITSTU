#/bin/bash

#Meno: Dominik Zatovic
#Cviko: J. Petrik stvrtok 16:00
#Datum: 10.12.2023
#Zadanie: z5

#Zadanie - text:
#Zistite, ktory pouzivatelia sa prihlasuju na server Os z viac ako 10tich roznych
#strojov za poslednu dobu (odkedy system zaznamenava tieto informacie)
#Ak bude skript pusteny s prepinacom -n <pocet>, zistite, ktori pouzivatelia sa hlasia
#z viac ako n strojov.
#Ignorujte prihlasenia, pre ktore nepoznate IP adresu stroja
#Pomocka: pouzite prikaz last a udaje zo suboru /public/samples/wtmp.2020

#Syntax:
#zadanie.sh [-h] [-n <pocet>]

#Output: '<meno pouzivatela> <pocet strojov, z ktorych sa prihlasili>'
# Usage: <meno_programu> <arg1> <arg2> ...
# <arg1>: xxxxxx
# <arg2>: yyyyy
#
# Parametre uvedene v <> treba nahradit skutocnymi hodnotami.
# Ked ma skript prehladavat adresare, tak vzdy treba prehladat vsetky zadane
# adresare a vsetky ich podadresare do hlbky.
# Pri hladani maxim alebo minim treba vzdy najst maximum (minimum) vo vsetkych
# zadanych adresaroch (suboroch) spolu. Ked viacero suborov (adresarov, ...)
# splna maximum (minimum), treba vypisat vsetky.
#
# Korektny vystup programu musi ist na standardny vystup (stdout).
# Chybovy vystup programu by mal ist na chybovy vystup (stderr).
# Chybovy vystup musi mat tvar (vratane apostrofov):
# Error: 'adresar, subor, ... pri ktorom nastala chyba': popis chyby ...
# Ak program pouziva nejake pomocne vypisy, musia mat tvar:
# Debug: vypis ...
#
# 
#
# Riesenie:

#Print help 

print_help() {
	echo "Syntax: $0 [-h] [-n <pocet>]"
	echo "Options:"
	echo " -h		Zobrazi tuto napovedu"
	echo " -n <pocet>	Zisti pouzivatelov, ktory sa prihlasuju z viac ako n strojov"
	}

#Default n if user doesnÂt input any specified number of machines
THRESHOLD=10
#Path to the wtmp file with logic record
WTMP_FILE="/public/samples/wtmp.2020"

#Check if the wtmp file exists
if [ ! -f "$WTMP_FILE" ]; then
	echo "Error: 'The wtmp.2020 file with records was not found.'"
	exit 1
fi

#Parse command line arguments
while (( "$#" )); do
	case "$1" in
		-n)
			#Check if the argument after -n is a valid (number)
			if [[ "$2" =~ ^[0-9]+$ ]]; then
				THRESHOLD=$2
			else
				echo "Error: 'Invalid format for the -n argument.'" >&2
				exit 1
			fi
			shift
			;;
		-h)
			#Display the message and exit
			print_help
			exit 0
			;;
		*)
			#Unknown argument
			echo "Error: 'Unknown argument.'">&2
			exit 1
			;;
	esac
	shift
done

#last command will extract login information, filter, and process the data
last -f "$WTMP_FILE" -w -i | awk '{print $1, $3}' | head -n -2 | grep -v "0.0.0.0" | sort | uniq | cut -d' ' -f1 | uniq -c | sort -rn | awk -v threshold=$THRESHOLD '{if ($1 > threshold) print "Output: \047" $2, $1 "\047"}'
#Exit the script with a success status
exit 0

