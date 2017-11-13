#!/bin/bash

GREEN='\033[0;32m' #color green
NC='\033[0m' # No Color
bye="false" # Allow the program to stay open
while [ $bye = "false" ]
do
clear #clears the screen
echo -e "Please select from the following options"
echo -e "${GREEN}Single HDD${NC}"
echo -e "${GREEN}RAID 0${NC}"
echo -e "${GREEN}RAID 1${NC}"
echo -e "${GREEN}RAID 01${NC}"
echo -e "${GREEN}RAID 100${NC}"
echo -e "${GREEN}bye${NC} to exit"

read option
option="${option,,}"
echo $option > $outputfile

case "$option" in #select the Raid type to select

	"single hdd") bash SingleRaid.sh
		clear
		echo "Would you like to continue?"
		read continue
		case "$continue" in
			y|Y) bye="false";;
			n|N) bye="true";;
		esac;;

	"raid 0") bash RAID0.sh
		clear
		echo "Would you like to continue?"
		read continue
		case "$continue" in
			y|Y) bye="false";;
			n|N) bye="true";;
		esac;;

	"raid 1") bash RAID1.sh
		clear
                echo "Would you like to continue?"
                read continue
                case "$continue" in
                        y|Y) bye="false";;
                        n|N) bye="true";;
		esac;;

        "raid 01") bash RAID01.sh
		clear
		echo "Would you like to continue?"
		read continue
		case "$continue" in
			y|Y) bye="false";;
			n|N) bye="true"	;;
		esac;;
        "raid 100") bash RAID100.sh
		clear
		echo "Would you like to continue?"
		read continue
		case "$continue" in
			y|Y) bye="false";;
			n|N) bye="true";;
		esac;;

        "bye")
		echo "Are you sure? Y/N"
		read reply
                case "$reply" in

                        y|Y)    bye="true"
                                exit 1
                                ;;
                        n|N)    bye="false";;
                esac
esac
done
exit
