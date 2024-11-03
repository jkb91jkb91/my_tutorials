# THIS IS TUTORIAL ON HOW TO USE PROMETHEUS WITH EXPORTERS  

1.) PROVISIONING   
2.) CONFIGURATION FILE  
3.) ALERTS    
4.) ACTION ON ALERTS  



1.) PROVISIONING  
a) SERVER_1 >> RUN docker-compose up -d   
b) SERVER_2 >> RUN configure_apache.sh  

2.) CONFIGURATION FILE  

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
      - targets: ['34.55.219.151:9117']
```

3.) ALERTS   
a) apache_alerts.yml  
b) other_alerts.yml  
