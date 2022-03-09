Software uses a symmetric key pairing, and then imports its own .pub. One could move the encrypted files to a new 
system, and if they know the password, the decryption key will work the same. Can handle multiple types of files
including PDF,txt, JPEG,PNG. Designed to work with CronJobs for automatic encryption of files that are placed into 
the chosen drop directory, program can also decrypt (with the password) to the chosen output directory. 

-f will immediately encrypt the directory
-a use with cronjobs for automatic encrytion and notification
-i for initialization, however will not work if its already initialized. You need to reset it first

The menu has options to view the preferences set by the user. You can also choose to decrypt a singular file, or
the entirety of the encrypted directory. Both need the correct passphrase that was set at initialization. Resetting
the program will also require the passphrase, then it will decrypt everything to the output location, delete its own
datafile containing user preferences, and then delete the encryption key. You'll automatically be prompted to 
re-initialize the program. 

When running via -a and cronjobs, if the program isnt initialized, you'll be notified, else youll recieve notification 
that the encryption had taken place. If running very regularly (e.g. per minute) do not allow the display in the cron
tab. Otherwise the notification can become a nuisance
