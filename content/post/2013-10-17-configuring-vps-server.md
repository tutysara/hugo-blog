+++
title = "Setting up a  new VPS server"
date = "2013-10-18T11:16:00"
tags = ["self-notes"]
+++

These are the things I did to setup new VPS instances on Digital Ocean and ChicagoVPS

### Update the machine
```bash
sudo apt-get update
sudo apt-get upgrade
```
### Set locales
```bash
sudo locale-gen
sudo dpkg-reconfigure locales
```
### add user
```bash
sudo adduser tutysra
# give sudo previliges
sudo visudo
tutysra ALL=(ALL) ALL
```
### Install Git
```bash
sudo apt-get install git
```
### Install sun java
```bash
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java7-installer
```
### Install Tor for screen scrapping
```bash
sudo apt-get install tor
sudo /etc/init.d/tor start
```
### Make default directories
```bash
mkdir ~/swt
mkdir ~/bin
```
### Install NX ( not necessary for CLI boxes)
```bash
export DEBIAN_FRONTEND=noninteractive
sudo -E apt-get update
sudo -E apt-get install -y ubuntu-desktop
sudo apt-get install gnome-session-fallback

wget 'http://64.34.173.142/download/3.5.0/Linux/nxclient_3.5.0-7_amd64.deb'
wget 'http://64.34.173.142/download/3.5.0/Linux/nxnode_3.5.0-9_amd64.deb'
wget 'http://64.34.173.142/download/3.5.0/Linux/FE/nxserver_3.5.0-11_amd64.deb'

sudo dpkg -i *.deb
sudo /usr/NX/bin/nxserver --status

nano /usr/NX/etc/node.cfg
# Uncomment the “DefaultXSession” line and set it to :
DefaultXSession=/etc/X11/Xsession
```

### Enable/Disable password authentication in ssh
```bash
sudo vi /etc/ssh/sshd_config
 PasswordAuthentication to "yes/no" 
 PermitRootLogin no
sudo service ssh restart
```
### Install screen & tmux
```bash
sudo apt-get install screen
sudo apt-get install tmux
```
### Install curl
```bash
sudo apt-get install curl
```
### Install emacs and customize
```bash
sudo apt-get install software-properties-common # installs some python scripts necessary for these operations
sudo add-apt-repository ppa:cassou/emacs
sudo apt-get update
sudo apt-get install emacs-snapshot-el emacs-snapshot-gtk emacs-snapshot
export TERM=xterm-256color
```
### Install lein
```bash
mkdir ~/bin && cd ~/bin
wget 'https://raw.github.com/technomancy/leiningen/stable/bin/lein'
```
### Install JDK6 for neo4j
```bash
wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" http://download.oracle.com/otn-pub/java/jdk/6u41-b02/jdk-6u41-linux-x64.bin 

export JAVA_HOME=/home/neo4j/swt/jdk1.6/
export PATH=/home/neo4j/swt/jdk1.6/bin:$PATH
```
### Configure swap
My ChicagoVPS runs on OpenVZ and Swap space couldn't be enabled at VM level.

```bash
swapon -s
sudo dd if=/dev/zero of=/swapfile bs=1024 count=2048k
sudo mkswap /swapfile
sudo swapon /swapfile
swapon -s

sudo nano /etc/fstab
/swapfile       none    swap    sw      0       0 

sudo chown root:root /swapfile 
sudo chmod 0600 /swapfile

sudo nano /etc/sysctl.conf 
vm.swappiness=20  # default is 60% RAM full
```
### Configure Timezone from command line
```bash
sudo dpkg-reconfigure tzdata
```
### Install ngnix
```bash
sudo apt-get install nginx
sudo service nginx start
#ifconfig eth0 | grep inet | awk '{ print $2 }'
update-rc.d nginx defaults
```
#### configuring ngnix
sudo invoke-rc.d nginx reload
[Follow instructions here]( https://help.ubuntu.com/community/Nginx/ReverseProxy)

### Install latest tomcat from apache
```bash
sudo apt-get install tomcat7 - Not fine
Download from - http://apache.techartifact.com/mirror/tomcat/tomcat-7/v7.0.37/bin/apache-tomcat-7.0.37.tar.gz
```
Edit .bashrc
```bash
export JAVA_HOME=/usr/lib/jvm/java-7-oracle
export CATALINA_HOME=~/swt/tomcat
$CATALINA_HOME/bin/startup.sh
```
### Install mongodb
```bash
url - http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/10gen.list
sudo apt-get update
sudo apt-get install mongodb-10gen
data - /var/lib/mongodb
log - /var/log/mongodb
use - mongodb
```
# Server Monitoring
### Install htop
```bash
sudo apt-get install htop
```
### Install iftop
```bash
sudo apt-get install iftop
```
### Install munin
```bash
sudo apt-get install munin munin-node
sudo /etc/init.d/munin-node restart
results - /var/cache/munin/www #sync to dropbox
```
# Server Checking
```bash
sudo apt-get install nmap
port scan - sudo nmap -v -sT localhost
syn scan - sudo nmap -v -sS localhost
```
# Allow automatic system updating
```bash
sudo apt-get install unattended-upgrades
sudo dpkg-reconfigure unattended-upgrades
```
# IPTables configuration
```bash
sudo iptables -L
sudo iptables -L -n # no dns lookup for ip to hostname resolution

# flush all existing rules
sudo iptables -F
sudo iptables -I INPUT 1 -i lo -j ACCEPT # accept loopback
sudo iptables -I INPUT 2 -p tcp --dport ssh -j ACCEPT # allow ssh
sudo iptables -I INPUT 3 -p udp --dport 60000:61000 -j ACCEPT # allow mosh
sudo iptables -I INPUT 4 -p tcp --dport 80 -j ACCEPT # allow www
sudo iptables -I INPUT 5 -p udp -m udp --dport 53 -j ACCEPT # allow dns
sudo iptables -A INPUT -j DROP
sudo iptables -L -v

#self note - see bitbucket for rules file
# allow all existing connections
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# persist rules
sudo apt-get install iptables-persistent
sudo service iptables-persistent start
sudo /etc/init.d/iptables-persistent save

```

If you do something more/different, please comment, I will refine my setup and this blog post. Thanks.
