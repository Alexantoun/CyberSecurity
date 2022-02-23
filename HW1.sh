#!/bin/bash
function decryptDirectory(){
    location=$(cat dataFile.txt | grep destination | cut -c 13-)
    cd EncryptedFiles
    for fileName in *; do   
        echo "$fileName is encrypted"
        cat "$fileName"
        echo ""
        gpg --output ~/"$location"/DecryptedFiles/"$fileName" -d "$fileName" 
        clear
    done
    echo "All files decrypted and placed into ~/$location"
    gpg-connect-agent reloadagent /bye

}

function encryptDirectory(){
    location=$(cat dataFile.txt | grep location | cut -c 10-)
    cd ~/"$location"/AutoEncrypt
    echo "Trying to encrypt $location"
    pwd
    for fileName in *;do   
        gpg -o ~/Documents/CyberSecurity/EncryptedFiles/"$fileName" -e -r AutoEncrypt "$fileName"
        rm  ~/"$location"/AutoEncrypt/"$fileName"
        echo "encrypted $fileName";
    done
    gpg-connect-agent reloadagent /bye
}

function makeKey(){
    passphrase=$(whiptail --title "Need a passphrase" --passwordbox "Please enter a passphrase" 10 60 3>&1 1>&2 2>&3)
    exitstatus=$?
    if [[ $exitstatus = 0 ]]; then
        echo "%echo Generating a key"> genkey-batch
        echo "Key-Type: default" >> genkey-batch
        echo "Subkey-Type: default" >> genkey-batch
        echo "Name-Real: AutoEncrypt" >> genkey-batch
        echo "Name-Email: AutoEncrypt@here.com" >> genkey-batch
        echo "Expire-Date: 0" >> genkey-batch
        echo "Passphrase: $passphrase" >> genkey-batch
        echo "%echo done" >> genkey-batch
        echo Making a key with the batch
        gpg --batch --gen-key genkey-batch
        rm genkey-batch
    else
        echo "Operation Cancelled"
    fi
    gpg-connect-agent reloadagent /bye
}

function initialize(){
    echo "This is for an initial setup"
    existance=$( gpg --list-keys | grep AutoEncrypt ) 
    if ! [[ $existance ]]; then
        echo "Need to generate a new Public/Private key pairing"
        sleep 0.5
        makeKey
    else
        echo "AutoEncrypt Key already exists"
    fi 
    read -p "Please enter the AutoEncrypt location: ~/" location
    echo "location $location" > dataFile.txt
    location2=$(cat dataFile.txt | grep location | cut -c 10-)
    if [[ -d ~/"$location2"/AutoEncrypt ]]; then  
        echo "AutoEncrypt directory exists in ~/$location2"
    else
        mkdir ~/"$location2"/AutoEncrypt
        echo "Created Directory in ~/$location2"
    fi

    if [[ -d "EncryptedFiles" ]]; then
        echo "Encryption directory exists"
    else
        mkdir EncryptedFiles
    fi

    read -p "Enter Decryption output location: ~/" location
    if [[ -d ~/"$location"/DecryptedFiles ]]; then
        echo "Decryption directory already exists"
        echo "destination $location" >> dataFile.txt

    else
        mkdir ~/"$location"/DecryptedFiles
        echo "destination $location" >> dataFile.txt
    fi
}

if  [[ $1 == -a ]]; then
    if [[ -e dataFile.txt ]];then 
        notify-send 'Auto Encryption' 'Input directory has been encrypted'
        encryptDirectory
    else
        notify-send 'Auto Encryption no Initialized' 'AutoEncrypt needs to be initialized'
    fi
elif [[ $1 == -f ]]; then
    echo "Encrypting entirety of AutoEncrypt directory"
    sleep 1
    encryptDirectory

elif [[ $1 == -i ]]; then
    initialize

else
    if [[ -e dataFile.txt ]]; then
        clear
        echo "Auto-Encryption: Please select from the following options"
        echo "1: Change Keys"
        echo "2: Delete Encryption keys"
        echo "3: Decrypt a file"
        echo "4: Decrypt All files"
        read response
        if [[ $response == 1 ]]; then
            echo "You have chosen to Change the encryption/decryption keys"
        elif [[ $response == 3 ]]; then
            file="$(whiptail --title "Choose file" --inputbox "Specify the file to decrypt" 10 60 3>&1 1>&2 2>&3)"
            location="$(cat dataFile.txt | grep destination | cut -c 13- )"
            echo "the output location is $location"
            if [[ -d ~/"$location"/DecryptedFiles ]]; then
                if [[ -e EncryptedFiles/"$file" ]]; then
                    gpg -o ~/"$location"/DecryptedFiles/"$file" -d EncryptedFiles/"$file"
                    rm EncryptedFiles/"$file"
                    echo "File decrypted in DecryptedFiles Directory"
                    gpg-connect-agent reloadagent /bye
                else
                    echo "File not found"
                fi
            else
                echo "Decryption location not set"
            fi
        elif [[ $response == 4 ]]; then
            decryptDirectory
        fi
    else 
        whiptail --title "Need to initialize AutoEncrypt" --yesno "Do you want to initialize AutoEncrypt?" 10 60 3>&1 1>&2 2>&3
        if [[ $? = 1 ]]; then
            echo "Aborted"
        else
            initialize
        fi
    fi
fi