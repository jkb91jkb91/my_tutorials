


# ON SERVER WITH INTERNET
Install server squid
```
sudo apt install squid -y
```
Add to configuration these lines >>>
```
acl SSL_ports port 443
# ADD YOUR LOCAL NETWORK ADDRESS
acl localnet src 10.0.0.0/8
http_access allow localnet SSL_ports
```
Restart squid
```
sudo systemctl restart squid
```

# ON SERVER WITHOUT INTERNET
1) Check address of your VM with proxy, let's say it is 10.0.0.6  
Create this file and fill >>  
```
/etc/apt/apt.conf.d/95proxies
```
Put inside  
```
Acquire::http::Proxy "http://10.0.0.6:3128/";
Acquire::https::Proxy "http://10.0.0.6:3128/";
```

2) Test if you can update packages
```
apt-get update 
```
