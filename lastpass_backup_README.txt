INTRODUCTION
-------------------------------------------------------------------------------
This directory contains a script that downloads user(s) LastPass vaults and 
saves it to a GPG-encrypted CSV file. 


METHOD OF OPERATION
-------------------------------------------------------------------------------
It will create a directory for each user. In that directory, there will be 
daily midnight backup files. It accomplishes this using a cronjob that runs the 
script every day at midnight.


USING SCRIPT
-------------------------------------------------------------------------------
The script is called 'lastpass_backup.sh'.
To add user accounts, add them to the 'lpass_users' associative array.

For best practice, please run 'lpass login --trust <USERNAME>' first to make
sure that all two-factor authentication requirements are satisfied. This will 
create a hidden directory in ~/.lpass and store metadata files there. 

Also, make sure that you have a GPG agent active and public signing key
present. This is required so you can encrypt the incoming data streams. 
To begin backing up user LastPass vaults, simply run the script if you
performed the checks above. 


VIEWING BACKUPS
-------------------------------------------------------------------------------
To view the files, make sure your GPG key is 
loaded and run 'gpg <FILE.csv.gpg>'. This will create a new <FILE.csv> in the
same directory. When you done with it, please delete fully by running :

shred -fzu <FILE.csv>


LASTPASS IMPORT
-------------------------------------------------------------------------------
First, login to your LastPass account:

lpass login --trust <USERNAME>

Then, decrypt your backup file.

gpg <FILE.csv.gpg>

Import into LastPass:

lpass import <FILE.csv>

Logout:

lpass logout




