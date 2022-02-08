#!/bin/bash
##you still need to make the generation of keys manual
if  [[ $1 == -a ]]; then
    echo "Automatic run for the crontab"
elif [[ $1 == -f ]]; then
    echo "Forced to encrypt directory"
    cd ~/Desktop/EncryptMe
    gpg -e *.txt
    mv  *.txt.gpg ~/Documents/CyberSecurity/theTest.txt 
    cd ~/Documents/CyberSecurity
elif [[ $1 == -i ]]; then
    echo "********************Fix me******************"
    cd ~/Desktop
    mkdir EncryptMe
    cd ~/Documents/CyberSecurity

    pwd
    ##read -p "enter encryption folder location and name: " usrInput
    ##touch location.txt
    ##echo "~/$usrInput" > location.txt
    ##cat location.txt
    #cd "$(< location.txt)"
else
    echo "Welcome, Please select from the following options"
    echo "1: Change Keys"
    echo "2: do something else"
    echo "3: Decrypt a file"
    read response
    if [[ $response == 1 ]]; then
        echo "You have chosen to Change the encryption/decryption keys"
    elif [[ $response == 3 ]]; then
        echo -n "would you like to export decrypted file?(y/n): "
        read response
        if [[ $response == 'y' || $response == 'Y' ]]; then
            echo "You have chosen: $response"
        else
            echo "You have not chose 'y'"
        fi 
    fi

fi