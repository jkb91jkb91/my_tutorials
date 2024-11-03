# INFO

1.) Use configure_apache.sh to provision whole remote server with apache_exporter  
2.) Use prometheus.yml  
3.) Use apache_alerts.yaml  

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
