# CyberSecurity
Homework Assignment, creating a local dropbox to encrypt files stored into a specified directiory into one holding the encrypted files

Right now this script will generate an encryption key, allow you to choose location of the dropbox, and
creates a folder to hold the encrypted files.

At this stage im still developing a way to force the encryption of the dropbox

"DropBox" is a placeholder name

14th of February 2022:--
Can now decrypt a specified file by taking the file name from the user and then storing to a directory called
DecryptedFiles -- will work on allowing the user to specify location of decryption

forced encryption will now encrypt the entire directory, and move them to the encryption location 

Added a way to choose the destination of the decrypted files but still no way to decrypt the entirety of the encrypted directory 

16th February 2022:--
Can now decrypt the entirety of the holding directory, the decrypted files will be placed into 
the location specified by the user. 

21st February 2022:--
Actually fixed the automatic encryption key generation whilst using users passphrase

22nd February 2022:-- made the decryption file talk to the new encryption method. Decided to delete the 
piping of the passphrase to gpg -d 


23rd February 2022:--
More menu fucntionality, and can initialize when trying to run without sending parameters from the command line
made a whiptail to decrypt specific files, maybe I can make a menu to choose?? 

24th February 2022:--
Continuing work on the menu system but can now reset the program
