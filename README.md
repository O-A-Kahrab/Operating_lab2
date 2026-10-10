# Operating_lab2
this is a simple antivirus it detects any files with the extention (exe,vbs,ps1,scr,bat)
as well any file with any of the keywords(virus,trojan,worm,ransomware,malware) all case insensetive

the antivirus works by scanning the directory once when the file is ran and checks for any flagged file
if a file is deemed malicious it will be removed from the main directory to another one given by the user
if a file name was added to the whitelist it will not be flagged
after the loop is finished the info of the stored files is stored and the script sleeps for a certain amount of time given by the user "interval" after that the script checks if any file was added or edited for the scan to begin once more
----the antivirus needs three arguments (main_dir,malicious_dir,interval)

It also comes with a restore tool where it will open a menu containing all the quarantied files and let the user choose one of the files to either restore to the original directory,delete the file permenantly or go back to choose a different file
----the restore tool needs two arguments (main_dir,malicious_dir)

A whitelist is also icluded where the antivirus will look at whether the file name is in the whitelist or not if the file name is in the whitelist it will not be flagged

-----How to run?

open your terminal and use cd command to go to the script location
once there write the following command
===> make antivirus main_dir=YOUR_DIR malicious_dir=QUARANTINE_DIR interval=TIME_BEFORE_LOOP
where YOUR_DIR is the directory you want to scan,
QUARANTINE_DIR is the directory you want to keep any malicious files in
and TIME_BEFORE_LOOP is the time the program waits before scanning once more

when you are finished press ctrl + c in the terminal to force stop the script

for the restore tool write the command
===> make restore main_dir=YOUR_DIR malicious_dir=QUARANTINE_DIR
where YOUR_DIR is the same directory you wanted to scan 
and QUARANTINE_DIR is the directory where you saved any malicious files
you will see a menu with the files in the quarantine you can choose the file by entering its
corresponding number 
afterwards, you will be taken into another menu where you can choose
between: restoring the file to the main directory by entering 1
         Deleting the file permenantly by entering 2
         or going back to the previous menu by entering 3
and if you want to quit enter "q" in the first menu