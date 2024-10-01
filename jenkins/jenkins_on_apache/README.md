

# INFO
Run container with flag --cap-add=NET_ADMIN if you want to have more than one network connected like (bridge+MY_NETWORK)
Why ?  Because container may set MY_NETWORK as default route gateway and you wont have connection to internet
This flag give you permission to change default route gateway therafeter

```
ip route del default via 172.19.0.1
ip route add default via 172.17.0.1  #Standard default on bridge
```
So please run command in this way
```
docker run -d --name jenkins --cap-add=NET_ADMIN --network bridge -p 8080:8080 customized_jenkins
```
Now install on this container ip route
```
docker exec -it jenkins
apt-get update && apt-get install iproute2
exit
```

Add docker network
Adding this docker network may change your default route so you have to change it thereafter
```
docker create network --name MY_NETWORK
docker network ls
docker connect MY_NETWORK ID_CONTAINER

```

Check if your default bridge gateway changed or not
```
docker exec -it jenkins
root@9aeeb442c868:/# ip route
default via 172.19.0.1 dev eth2
172.17.0.0/16 dev eth0 proto kernel scope link src 172.17.0.3
172.19.0.0/16 dev eth2 proto kernel scope link src 172.19.0.2

ip route del default via 172.19.0.1
ip route add default via 172.17.0.1

```

Now you should connection to internet

# Bridge informations

```
docker network inspect bridge
[
    {
        "Name": "bridge",
        "Id": "215d546412051cc33cca483ba56ae53faabe52c848f27181707da68d7d84fed4",
        "Created": "2024-09-28T10:17:49.368061595+02:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16",
                    "Gateway": "172.17.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "9aeeb442c86886d701ba55921ebd7b60cf1f1b6b6cede42339c1c7814fb40269": {
                "Name": "jenkins",
                "EndpointID": "19bbbc202c485c8f48c3ab1f454a6fb91c83e01d7209761f3d4bf67972923ff3",
                "MacAddress": "02:42:ac:11:00:03",
                "IPv4Address": "172.17.0.3/16",
                "IPv6Address": ""
            },
            "c88b86120b56ca3be9e654aa35b560f7d9934d8b67a590d962346dcce257bc51": {
                "Name": "apache",
                "EndpointID": "514bdde34cbefbf599e82fdd3d6187f1ff6b9edc1ec159b0645bb046631f7f3a",
                "MacAddress": "02:42:ac:11:00:02",
                "IPv4Address": "172.17.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {
            "com.docker.network.bridge.default_bridge": "true",
            "com.docker.network.bridge.enable_icc": "true",
            "com.docker.network.bridge.enable_ip_masquerade": "true",
            "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
            "com.docker.network.bridge.name": "docker0",
            "com.docker.network.driver.mtu": "1500"
        },
        "Labels": {}
   
```



docker run -d --name apache -p 80:80 httpd
docker run -d --name jenkins --p 8080:8080 customized_jenkins


