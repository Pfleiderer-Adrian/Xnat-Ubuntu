# Xnat-Ubuntu
It's a modified dockerized XNAT version form the official XNAT Git-Repo with the following changes.

* Its modified and optimized for Ubuntu (should now work out of the box)
* installed OHIF Viewer & LDAP Plugin
* installed Docker-Pipeline-Engine
* fixed Processing URL BUG
* some spezific Ubuntu changes

## Preconditions
Ubuntu Server (>18)

## Usage
* Download the installScript.sh file
* copy the file to your Ubuntu Server in your root directory (Command: cd /)
* execute the file with the Command: sudo bash installScript.sh
* after the Server Reboot execute "cd /Xnat-Ubuntu" and "docker-compose up -d"
* after several minutes look at localhost
 
## Configuration
* first change your admin password und (default credentials: Name: admin, PW: admin)
* change processing url to your side url under Administer -> Site Administration -> Pipeline Settings -> Processing Url
