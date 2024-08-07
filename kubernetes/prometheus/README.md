# PROMETHEUS & GRAFANA TUTORIAL

# TAK POBIERAMY HELM CHARTA
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm pull prometheus-community/prometheus --version 25.12.0

tar -xf prometheus-25.12.0.tgz 
helm install prom ./prometheus

export POD_NAME=$(kubectl get pods --namespace web -l "app.kubernetes.io/name=prometheus,app.kubernetes.io/instance=prom" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace web port-forward $POD_NAME 9090



NAME                                           READY   STATUS    RESTARTS   AGE
prom-alertmanager-0                            1/1     Running   0          22h
prom-prometheus-node-exporter-br8sw            1/1     Running   0          22h
prom-prometheus-node-exporter-k7zwk            1/1     Running   0          22h
prom-prometheus-node-exporter-nkng4            1/1     Running   0          22h
prom-prometheus-pushgateway-85f5dcd896-jm9gq   1/1     Running   0          22h
prom-prometheus-server-694c5c5d8c-tjvbt        2/2     Running   0          22h

NAME                            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
prom-alertmanager               ClusterIP   10.96.108.240   <none>        9093/TCP   38h
prom-alertmanager-headless      ClusterIP   None            <none>        9093/TCP   38h
prom-prometheus-node-exporter   ClusterIP   10.96.121.18    <none>        9100/TCP   38h
prom-prometheus-pushgateway     ClusterIP   10.96.64.252    <none>        9091/TCP   38h
prom-prometheus-server          ClusterIP   10.96.108.76    <none>        80/TCP     38h

# Stworz NODE PORT MOZE BYC TROCHE NIELOGICZNE BO ROBIMY PORT_FORWARD 9090 a nie 80
# MUSISZ TO SPRAWDZIC CZEMU TAK JEST ZE AKURAT 80 a nie 9090
kubectl expose svc prom-prometheus-server --type=NodePort --target-port=9090 --name=prom-server-node-port

# GRAFAMA >> https://grafana.com/docs/grafana/latest/setup-grafana/installation/helm/
helm repo add grafana https://grafana.github.io/helm-charts
helm pull grafana/grafana
helm install grafana .
kubectl expose svc grafana --type=NodePort --target-port=3000 --name=grafananp

kubectl get secret grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
