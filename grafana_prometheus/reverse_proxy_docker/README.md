# MINIMAL prometheus.yaml file

```
global:
  scrape_interval: 15s  # Częstotliwość pobierania metryk

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
```


# Added apache_exporter

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
