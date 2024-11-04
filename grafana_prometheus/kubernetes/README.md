# INFO
https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack

1.) INSTALL HELM  
2.) UPDATE HELM REPOSITORY  
3.) INSTALL FOUND VERSION  



# 1 INSTALL HELM
```
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

# 2 UPDATE HELM REPOSITORY
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm search repo prometheus-community/kube-prometheus-stack --versions # 65.5.1
```

# 3 INSTALL FOUND VERSION
```
helm install my-prometheus prometheus-community/kube-prometheus-stack --version 65.5.1
```
