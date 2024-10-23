# CHANGE THIS FOR YOUR VALUES IN DOCKER_COMPOSE
1 DOMAIN >> projectdevops.eu  
GENERATE CERTS AND CHANGE BELOW  
2 crt NAME >> projectdevops.eu  
3 key NAME >> projectdevops.eu  

```
version: '3'

services:
  grafana:
    image: grafana/grafana
    container_name: grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SERVER_ROOT_URL=https://projectdevops.eu/grafana/

  apache:
    image: httpd:2.4
    container_name: apache
    ports:
      - "443:443"
    volumes:
      - ./httpd.conf:/usr/local/apache2/conf/httpd.conf
      - ./projectdevops.eu.key:/usr/local/apache2/conf/projectdevops.eu.key  
      - ./projectdevops.eu.crt:/usr/local/apache2/conf/projectdevops.eu.crt  

  prometheus:
    image: prom/prometheus
    container_name: prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    environment:
      - PROMETHEUS_EXTERNAL_URL=https://projectdevops.eu/prometheus
    command:
      - '--web.external-url=https://projectdevops.eu/prometheus'
      - '--web.route-prefix=/'
      - '--config.file=/etc/prometheus/prometheus.yml' 

```

# CHANGE THIS IN httpd.conf


NAME OF YOUR DOMAIN  

```

ServerName projectdevops.eu

SSLCertificateFile /usr/local/apache2/conf/projectdevops.eu.crt
SSLCertificateKeyFile /usr/local/apache2/conf/projectdevops.eu.key

```


