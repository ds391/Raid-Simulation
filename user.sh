#/bin/bash
GREEN='\033[0;32m' #color green
NC='\033[0m' # No Color
bye="false";
username=$1
pin=$(awk '/'$username'/{print $2}' UPP.db)
password=$(awk '/'$username'/{print $3}' UPP.db)

bye(){
echo "are you sure? Y/N"
read -r answer;
answer="${answer,,}"
if [ "$answer" = "y" ]; then
        exit 1;
fi
}

changepassword(){
local pincorrect="false"
while pincorrect="false"
do
        echo "please enter this user's pin"
        read -r ipin
        ipin="${ipin,,}"
        echo $pin > $outputfile
        if [ "$pin" = "bye" ]; then
                bye;
        fi
        if [ "$ipin" = "$ipin" ]; then
                pincorrect="true"
		echo "please enter the new password"
		read -r npassword
		npassword="${npassword,,}"
		#remove and then recreate user with new password
		awk '!/'$username'/' UPP.db > tmpfile && mv tmpfile UPP.db
		echo -e "$username $pin $npassword " >> UPP.db
                echo "user password has been changed"
        else
                echo "error wrong PIN"
        fi
done
}


while [ "$bye" = "false" ]
do
clear #clears the screen
echo -e "what would you like to do"
echo -e "${GREEN}Change${NC} Password"
echo -e "${GREEN}HDD${NC} Simulaton"
echo -e "${GREEN}bye${NC} to exit"

read -r option
option="${option,,}"
echo $option > $outputfile
#select admin function
case "$option" in
	change) changepassword;
		echo "Would you like to continue?"
                read -r continue
                case "$continue" in
                        y|Y) bye="false";;
                        n|N) bye="true";;
                esac;;
        hdd) bash menu.sh;
                echo "Would you like to continue?"
                read -r continue
                case "$continue" in
                        y|Y) bye="false";;
                        n|N) bye="true";;
                esac;;
        bye) bye;
esac
done
echo $outputfile > log.db
rm $outputfile


