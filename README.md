# Xnat-Ubuntu
It's a modified dockerized XNAT version form the official XNAT Git-Repo with the following changes.

* Its modified and optimized for Ubuntu (should now work out of the box)
* installed OHIF Viewer & LDAP Plugin
* installed Docker-Pipeline-Engine
* fixed Processing URL BUG
* some specific Ubuntu changes

## Preconditions
Ubuntu Server (>18)

## Usage
* Download the installScript.sh file
* copy the file to your Ubuntu Server in your root directory (Command: cd /)
* execute the file with the Command: sudo bash installScript.sh
* after the installation and several minutes to take the side up look at localhost Port: 8081
* now make the necessary configuration for ubuntu (processing url workaround & admin password change)
* after these changes you can access your XNAT on localhost without a specific port
 
## Necessary Configurations
* first change your admin password (default credentials -> Name: admin, PW: admin)
* change processing url to your side url under Administer -> Site Administration -> Pipeline Settings -> Processing Url
* change the side url to your side url under Administer -> Site Administration -> Site Setup -> Site Url
* stop your docker service and wait until everything is stopped ("cd /Xnat-Ubuntu" and "docker-compose stop"). very importent!
* restart your server ("reboot") and start your service again ("cd /Xnat-Ubuntu" and "docker-compose up -d")

## Pipeline Configurations
### Add "Execute Pipeline"-Button on Options Menü in SessionData
* navigate: Administer -> Data Types -> 
* choose SessionData Element witch should have Execute option
* click on the Element and on Edit-Button
* scroll down to "Available Report Actions"
* one the last entry in this table write: Name->PipelineScreen_launch_pipeline, Display Name->Build, Secure Access->edit
* scroll down again and click on the "Submit"-Button

Now should appear a "Execute Pipeline"-Button when you open a Project with the specific SessionData Element. There you can execute a Pipeline for the Project Data if you have added a Pipeline.

### Add a Pipeline to your XNAT System
-TODO-

