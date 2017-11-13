#!/bin/bash
clear
ucorrect=0
pcorrect=0
echo "please enter your username:"
read -r u
u="${u,,}"
while [ $ucorrect -eq 0 ]
do
        if [ "$u" = bye ]; then
                echo "you have chosen to exit, goodbye"
                exit 1
        fi
        login=$(awk '/'$u'/{print $1}' UPP.db)
        if [ "$u" = "$login" ]; then
                ucorrect=1
                break
        else
                echo "error username does not exist"
        fi
done

while [ $pcorrect -eq 0 ]
do
        echo "please enter your password:"

        read -rs password
        password="${password,,}"
        if [ "$password" = bye ]; then
                echo "you have chosen to exit, goodbye"
                exit 1
        fi

        login=$(awk '/'$u'/{print $3}' UPP.db)

        echo $login

        if [ "$password" = "$login" ]; then
                pcorrect=1
                loggedin=$(awk '/'$u'/' UPP.db)
		export outputfile="$username".temp
                $loggedin >> $outputfile
                now="$(date +'%d/%m/%Y')"
                $now >> loggedin.temp

                if [ $u = "admin" ]; then
                        bash admin.sh
			wait
                else
                        bash user.sh
			wait
                fi
        else
                echo "error wrong password"
	fi
done
exit 1
