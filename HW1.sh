#!/bin/bash
##you still need to make the generation of keys manual

function decryptDirectory(){
    location=$(cat systemInfo.txt | grep destination | cut -c 13-)
    cd EncryptedFiles
    read -p "Please enter Decryption key" key
    for fileName in *; do   
        echo "$fileName is encrypted"
        cat "$fileName"
        echo ""
        echo key | gpg --output ~/"$location"/DecryptedFiles/"$fileName" -d "$fileName" 
        rm "$fileName"
        clear
        echo "All files decrypted and placed into ~/$location"
    done
}

function encryptDirectory(){
    location=$(cat systemInfo.txt | grep location | cut -c 10-)
        cd ~/"$location"/DropBox
        for fileName in *;do   
            gpg -o ~/Documents/CyberSecurity/EncryptedFiles/"$fileName" -e "$fileName"
            rm  ~/"$location"/AutoEncrypt/"$fileName"
            echo "encrypted $fileName";
        done
}

if  [[ $1 == -a ]]; then
    notify-send 'Auto Encryption' 'Input directory has been encrypted'
    encryptDirectory

elif [[ $1 == -f ]]; then
    echo "Encrypting entirety of AutoEncrypt directory"
    sleep 1
    encryptDirectory

elif [[ $1 == -i ]]; then
    echo "This is for an initial setup"
    existance=$( gpg --list-keys | grep AutoEncrypt ) 
    if ! [[ $existance ]]; then
        echo "Need to generate a new Public/Private key pairing"
        sleep 1.5
        cd ~
        gpg --quick-gen-key AutoEncrypt [1[1024[0]]]
        gpg --export > theKey.pub
        gpg --import theKey.pub
        rm theKey.pub
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

else
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
        read -p "Enter the file name as fileName.ext: " response
        location="$( cat systemInfo.txt | grep destination | cut -c 13- )"
        echo "the output location is $location"
        if [[ -e ~/"$location"/DecryptedFiles ]]; then
            if [[ -e EncryptedFiles/"$response" ]]; then
                gpg -o ~/"$location"/DecryptedFiles/"$response" -d EncryptedFiles/"$response"
            echo "File decrypted in DecryptedFiles Directory"
            else
                echo "File not found"
            fi
        else
            echo "Decryption location not set"
        fi
    #elif [[ $response == 2 ]]; then
    
    elif [[ $response == 4 ]]; then
        decryptDirectory
    fi
fi