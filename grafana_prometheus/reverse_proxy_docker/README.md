# THIS IS TUTORIAL ON HOW TO USE PROMETHEUS WITH EXPORTERS  

1.) PROVISIONING   
2.) CONFIGURATION FILE  WITH APACHE_EXPORTER  
3.) API  
4.) ALERTS    
5.) ACTION ON ALERTS  



# 1.) PROVISIONING  
a) SERVER_1 >> RUN docker-compose up -d   
b) SERVER_2 >> RUN configure_apache.sh  # THIS WILL INSTALL && RUN APACHE EXPORTER ON 9117  
- CHECK IF SERVICE IS RUNNING: systemctl list-units --type=service --state=running
- sudo lsof -i :9117

# 2.) CONFIGURATION FILE  WITH APACHE_EXPORTER  
prometheus.yaml  
```
global:
  scrape_interval: 15s  # Częstotliwość pobierania metryk

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'apache'
    static_configs:
      - targets: ['REMOTE_SERVER_IP:9117']
```

# 3.) API
To turn of API
```
 command:
      - "--web.enable-lifecycle"
```
Reload example  
```
curl -v -X POST http://localhost/prometheus/-/reload
```

# 4.) ALERTS   
a) apache_alerts.yml  
b) other_alerts.yml  
