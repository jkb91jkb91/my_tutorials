# MINIMAL prometheus.yaml file

```
global:
  scrape_interval: 15s  # Częstotliwość pobierania metryk

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
```
