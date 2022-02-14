#!/bin/bash
##you still need to make the generation of keys manual
if  [[ $1 == -a ]]; then
    echo "Automatic run for the crontab"
elif [[ $1 == -f ]]; then
    location=$(cat systemInfo.txt | grep location | cut -c 10-)
    echo "Immediate file encryption of directory"
    echo "If you can read me you have failed" > ~/"$location"/DropBox/test.txt
    gpg -o ~/Documents/CyberSecurity/EncryptedFiles/encrypted.txt -e -r DropBox ~/"$location"/DropBox/test.txt
    rm  ~/"$location"/DropBox/test.txt
elif [[ $1 == -i ]]; then
    echo "This is for an initial setup"
    existance=$(gpg --list-keys | grep DropBox) 
    if ! [[ $existance ]]; then
        echo "Need to generate a new Public/Private key pairing"
        sleep 3
        gpg --quick-generate-key DropBox [1[1024[0]]]
        gpg --export -a > theKey.pub
        gpg --import theKey.pub
        rm theKey.pub
    else
        echo "DropBox Key already exists"
        sleep 3
    fi 

    read -p "Please enter the dropbox location: ~/" location
    echo "location $location" > systemInfo.txt
    location2=$(cat systemInfo.txt | grep location | cut -c 10-)
    echo "$location2"
    if [[ -d ~"$location2" ]]; then  
        echo "Directory Exists"
    else
        mkdir ~/"$location2"/DropBox
        echo "Created dropbox in ~/$location2"
    fi
    if [[ -d "EncryptedFiles" ]]; then
        echo "Encryption directory exists"
    else
        mkdir EncryptedFiles
    fi

else
    clear
    echo "Welcome, Please select from the following options"
    echo "1: Change Keys"
    echo "2: Delete Encryption keys"
    echo "3: Decrypt a file"
    read response
    if [[ $response == 1 ]]; then
        echo "You have chosen to Change the encryption/decryption keys"
    elif [[ $response == 3 ]]; then
        read -p "Enter the file name as fileName.ext: " response

        if ! [[ -d DecryptedFiles ]]; then
            echo "Making \"DecryptedFiles\" Directory"
            mkdir DecryptedFiles
        fi
        if [[ -e EncryptedFiles/"$response" ]]; then
            gpg -o DecryptedFiles/"$response" -d EncryptedFiles/"$response"
        else
            echo "File not found"
        fi
        echo "File decrypted in DecryptedFiles Directory"
    fi

fi