reset
echo
echo
echo ---------------------------------------
echo Welcome to the installation from XNAT
echo ---------------------------------------
echo
echo This script installs:
echo
echo '-----> XNAT v.1.7'
echo '-----> Tomcat Websever'
echo '-----> Plugins & Pipelines'
echo '-----> Testdata and Skripts'
echo '-----> Pipeline Engine'
echo '-----> XNAT Container Service'
echo '-----> nrgix Proxy'
echo '-----> Xnat-Ubuntu'
echo '-----> Docker'
echo '-----> GIT'
echo '-----> JAVA'
echo
echo Please check:
echo 1. you run this script on Ubuntu v.18 '(minimal)' or bigger
echo 2. you have internet
echo 3. you have sudo privileges
echo
echo 'Start installation?'
select yn in 'Yes' 'No'; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done
echo
echo install System!
echo ---------------------------------------
cd /
sleep 2
echo
echo Update System
echo ---------------------------------------
sleep 5
apt-get install sudo
sudo apt-get update
sudo apt-get upgrade
echo
echo Install Java
echo ---------------------------------------
sleep 5
sudo apt install openjdk-8-jdk
apt-get install nano
echo
echo Install Docker
echo ---------------------------------------
sleep 5
sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo apt-get install curl
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo
echo Install GIT
echo ---------------------------------------
sleep 5
sudo apt install git
echo
echo Install XNAT
echo ---------------------------------------
sleep 5
mkdir -p /data/xnat/archive
mkdir -p /data/xnat/build
cd /
sudo git clone https://github.com/XxScottxX/Xnat-Ubuntu.git
cd Xnat-Ubuntu
sudo docker-compose up -d
chmod +x RESTApiTest/APItest.sh
chmod +x RESTApiTest/APItest_multifiles.sh

#workaround if processing url is not found
#apt-get install iptables
#iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 127.0.0.1:8081
#iptables -P INPUT ACCEPT
#iptables -P OUTPUT ACCEPT
#iptables -P FORWARD ACCEPT
