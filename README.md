Vprofile Project Setup Manual & Automated
Setup on Laptop


Prerequisuites:
1 HyperVisor ex: VirtualBox
   HOW TO INSTALL
   -check Kernel
   -use kernel in this command on Manjaro:
   >>sudo pacman -Syu virtualbox linux54-virtualbox-host-modules
2 Vagrant
  >>vagrant plugin install vagrant-hostmanager
3 VagrantCloud

Deployment on 5 different VMs  JAVA APP
LoadBalancer   NGINX
WebServer      TOMCAT
MessageBroker  RabbitMQ
DateBase       MySQL
DataBase Cache Memcached(connected with MySQL,queries goes here first before reaching MySQL)

Popular Vagrant commands:
-vagrant init (tworzy VAGRANTFILE)
-vagrant up
-vagrant ssh
-vagrant reload
-vagrant status

DEFAULT CREDENTIALS vagrant:vagrant
config.hostmanager.enabled = true THIS IS VAGRANTFILE parameter that updates /etc/host file
After doing vagrant up >> vagrant info
Current machine states:

db01                      running (virtualbox)
mc01                      running (virtualbox)
rmq01                     running (virtualbox)
app01                     running (virtualbox)
web01                     running (virtualbox)



>>vagrant ssh db01 >> cat /etc/hosts/
 
192.168.56.14   mc01

192.168.56.13   rmq01

192.168.56.12   app01

192.168.56.15   db01

192.168.56.11   web01

>> ping web01 -c 4




AUTOMATED PROVISIONING
add all scripts and update VAGRANTFILE with vm.provision "shell" 

>> vagrant up --provision
