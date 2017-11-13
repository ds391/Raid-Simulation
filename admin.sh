#/bin/bash
GREEN='\033[0;32m' #color green
NC='\033[0m' # No Color
bye="false";

function bye(){
echo "are you sure? Y/N"
read -r answer;
answer="${answer,,}"
if [ "$answer" = "y" ]; then
	#check if this works
	echo $outputfile >> log.db
        exit 1;
fi
}

newuser(){
	usernamecorrect=false
	passwordcorrect=false
	pincorrect=false

function_setvalues(){
if [ $usernamecorrect = true ] && [ $passwordcorrect = true ] && [ $pincorrect = true ]; then
        echo -e "$username $pin1 $password1 " >> UPP.db #output to file
        echo "user created, press any key to continue"
        read -r
else #just incase there are errors in the code
        echo "Something went wrong"
        echo "usernamecorrect is $usernamecorrect"
        echo "passwordcorrect is $passwordcorrect"
        echo "pincorrect is $pincorrect"
fi
}
function_username(){
local regex="^[[:alnum:]][[:alnum:]][[:alnum:]][[:alnum:]][[:alnum:]]"
if [ "$1" = bye ]; then
	bye;
else
	if grep "$regex" <<< "$1"; then
		usernamecorrect=true
	else
	 echo "username does not conform to format, please start again"
        fi
fi
}
function_password(){
if [ "$1" != "$2" ] ; then
	read -pr "Password has been incorrectly entered, please start again"
else
	passwordcorrect=true
fi
}
function_pin(){
local regex="^[0-9][0-9][0-9]"
if [ "$1" != "$2" ]; then
	read -r "Pins do not much, please start again"
else
	if grep "$pinregex" <<< "$1"; then
        	 pincorrect=true
	else
		echo "pin does not conform to format, please start again"
	fi
fi
}
while [ $usernamecorrect = false ]; do
    echo "Please enter the new username, bye to exit"
    read -r username
    username="${username,,}";
	echo $username > $outputfile
	if [ grep -l "$username" UPP.db > /dev/null ]; then
		echo "error, username already exists"
	else
		if [ "$username" = bye ]; then
        		bye;
        	else
                	if grep "$username" UPP.db; then
                        	echo "This username already exist please enter a different username"
                	else
                        	function_username "$username";
                	fi
        	fi
	fi
done

while [ $passwordcorrect = false ]; do
        echo "Please enter the new user's password, bye to exit"
        read -r password1
        password1="${password1,,}"
	echo $password1 > $outputfile
        if [ "$password1" = bye ] ; then
                bye;
        else
                echo "Please re-enter the new user's password, bye to exit"
                read -r password2
		echo $password2 > $outputfile
                password2="${password2,,}"
                if [ "$password2" = bye ] ; then
                        bye;
                else
                        function_password "$password1" "$password2";
                fi
        fi
done
while [ $pincorrect = false ]; do
        echo "Please enter a user pin for password recovery, bye to exit"
        read -r pin1
        pin1="${pin1,,}"
	echo $pin1 > $outputfile
        if [ "$pin1" = bye ]; then
                bye;
        else
                echo "please re-enter the user pin, bye to exit"
                read -r pin2
                pin2="${pin2,,}"
                if [ "$pin2" = bye ]; then
                        bye;
                else
                        function_pin "$pin1" "$pin2";
                fi
        fi
done
function_setvalues;
}
removeuser(){
local usernamecorrect="false"
local pincorrect="false"
	while usernamecorrect="false"
	do
        clear
        echo "please enter the username of the user you wish to remove"
        read -r name
        name="${name,,}"
	echo $name > $outputfile
		if [ "$name" = "bye" ];then
			bye;
		fi
        login=$(awk '/'$name'/{print $1}' UPP.db)
        if [ "$name" = "$login" ]; then
                usernamecorrect="true"
                break
        else
                echo "error username does not exist"
        fi
	done
	while pincorrect="false"
	do
        echo "please enter this user's pin"
        read -r pin
        pin="${pin,,}"
	echo $pin > $outputfile
		if [ "$pin" = "bye" ];then
			bye;
		fi
        login=$(awk '/'$name'/{print $1}' UPP.db)
        if [ "$name" = "$login" ]; then
                pincorrect="true"
                awk '!/'$name'/' UPP.db > tmpfile && mv tmpfile UPP.db #find all lines that are not user, print it to th$
                echo "user has been removed"
                break
        else
                echo "error wrong PIN"
        fi
	done
}
resetpassword(){
local usernamecorrect="false"
local pincorrect="false"
while usernamecorrect="false"
do
        clear
        echo "please enter the username of the user you wish to reset the password of"
        read -r name
        name="${name,,}"
	echo $name > $outputfile
		if [ "$name" = "bye" ];then
			bye;
		fi
        login=$(awk '/'$name'/{print $1}' UPP.db)
        if [ "$name" = "$login" ]; then
                usernamecorrect="true"
                break
        else
                echo "error username does not exist"
        fi
done

while pincorrect="false"
do
        echo "please enter this user's pin"
        read -r pin
        pin="${pin,,}"
	echo $pin > $outputfile
        login=$(awk '/'$name'/{print $2}' UPP.db)
        if [ "$pin" = "bye" ]; then
                bye;
        fi
        if [ "$name" = "$login" ]; then
                pincorrect="true"
		#remove then recreate user with password as password
                awk '!/'$name'/' UPP.db > UPP.db #find all lines that are not user, print it to th$
                echo -e "$name $pin password " > UPP.db
		echo "user password has been set to password"
                break
        else
                echo "error wrong PIN"
        fi
done
}



while [ "$bye" = "false" ]
do
clear #clears the screen
echo -e "what would you like to do"
echo -e "${GREEN}New${NC} User"
echo -e "${GREEN}Remove${NC} User"
echo -e "${GREEN}Reset${NC} User Password"
echo -e "${GREEN}HDD${NC} Simulaton"
echo -e "${GREEN}bye${NC} to exit"
read -r option
option="${option,,}"
echo $option > $outputfile
#select admin function
case "$option" in
        new) newuser;
                echo "Would you like to continue?"
                read -r continue
                case "$continue" in
                        y|Y) bye="false";;
                        n|N) bye="true";;
                esac;;
	remove) removeuser;
                echo "Would you like to continue?"
                read -r continue
                case "$continue" in
                        y|Y) bye="false";;
                        n|N) bye="true";;
                esac;;
	reset) resetpassword;
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
