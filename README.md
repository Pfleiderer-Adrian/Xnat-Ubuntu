# Xnat-Ubuntu
It's a modified dockerized XNAT version form the [official dockerized XNAT Git-Repo](http://github.com/NrgXnat/xnat-docker-compose) with the following changes.

* this Xnat is modified and optimized for Ubuntu
* simple installation Script (work out of the box)
* installed OHIF Viewer & LDAP Plugin
* installed Docker-Pipeline-Engine
* installed Container Plugin + Workaround
* fixed Processing URL BUG
* some specific Ubuntu changes
* APItest Script and TestPipeline

## Preconditions
Ubuntu Server (>18)

## Usage
* Download the installScript.sh file
* copy the file to your Ubuntu Server in your root directory (Command: cd /)
* execute the file with the Command: sudo bash installScript.sh
* after the installation and several minutes to look at your URL
* now make the necessary configuration (processing url & admin password change)
 
## Necessary Configurations
* first change your admin password (default credentials -> Name: admin, PW: admin)
* change processing url to your side url under Administer -> Site Administration -> Pipeline Settings -> Processing Url
* change the side url to your side url under Administer -> Site Administration -> Site Setup -> Site Url

## Pipeline Configurations
### Add "Execute Pipeline"-Button on Options Menu in SessionData
* navigate: Administer -> Data Types -> 
* choose SessionData Element witch should have Execute option
* click on the Element and on Edit-Button
* scroll down to "Available Report Actions"
* one the last entry in this table write: Name->PipelineScreen_launch_pipeline, Display Name->Build, Secure Access->edit
* scroll down again and click on the "Submit"-Button

Now should appear a "Execute Pipeline"-Button when you open a Project with the specific SessionData Element. There you can execute a Pipeline for the Project Data if you have added a Pipeline.

### Add a Pipeline to your XNAT System
You can add a Sample Pipeline that is already instlled with this installation.
* navigate: Administer -> Pipeline -> Add Pipeline
* choose the path: /data/xnat/pipeline/catalog/PipelineTest/SampleHelloWorldPipeline.xml
* Importend!! leave the Name Textfield empty. A Bug will accur with you choose a spezific name. 
* after confirm your settings you can add this pipeline to your project and test the pipelineengine

## Special mention
* Sourcefiles from offical XNAT Repo: [github.com/NrgXnat/xnat-docker-compose](http://github.com/NrgXnat/xnat-docker-compose)  [@johnflavin](http://github.com/johnflavin)
* Project Supervisor: [@muellerdo](http://github.com/muellerdo)
