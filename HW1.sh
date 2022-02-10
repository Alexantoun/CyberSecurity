#!/bin/bash
##you still need to make the generation of keys manual
if  [[ $1 == -a ]]; then
    echo "Automatic run for the crontab"
elif [[ $1 == -f ]]; then
    echo "Immediate file encryption of directory"
    echo "If you can read me you have failed" > ~/Desktop/EncryptMe/test.txt
    #cd ~/Desktop/EncryptMe
    gpg -o ~/Documents/CyberSecurity/encrypted.txt -e -r DropBox ~/Desktop/EncryptMe/*.txt 
    #cd ~/Documents/CyberSecurity
elif [[ $1 == -i ]]; then
    echo "********************Fix me******************"
    echo "This is for an initial setup"
    echo "First a new public/private key pairing must be set"
    gpg --quick-generate-key DropBox [1[1024[0]]]
    gpg --export -a > theKey.pub
    gpg --import theKey.pub
    rm theKey.pub
    read -p "Please enter the dropbox location":  location
    echo "~/$location" > systemInfo.txt
    location2=$(cat systemInfo.txt | grep [location])
    echo "$location2"
    echo "*****Creating a desktop location to drop off files*****"
    if [[ -d ~/Desktop/EncryptMe ]]; then  
        echo "Directory Exists"
    else
        mkdir ~/Desktop/EncryptMe
    fi

    cd ~/Documents/CyberSecurity
    ##read -p "enter encryption folder location and name: " usrInput
    ##touch location.txt
    ##echo "~/$usrInput" > location.txt
    ##cat location.txt
    #cd "$(< location.txt)"
else
    echo "Welcome, Please select from the following options"
    echo "1: Change Keys"
    echo "2: Delete Encryption keys"
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