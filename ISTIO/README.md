# ISTIOCTL INSTALLATION 
```
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.25.0 sh -
sudo mv istio-1.25.0/bin/istioctl /usr/local/bin/istioctl
istioctl version
```


#INSTALLATION ISTIO IN CLUSTER >>> DONE ONCE

Profiles:
-default
-demo
-minimal
-remote
-ambient
-empty
-preview

```
istioctl install --set profile=demo -y
kubectl get pods -n istio-system
```

```
 jkb91   ISTIO    main ≡  ?16    kubectl get pods -n istio-system
NAME                                    READY   STATUS    RESTARTS   AGE
istio-egressgateway-74d7f6cdfd-pqr7m    1/1     Running   0          3m58s
istio-ingressgateway-8576976bf6-nd9sf   1/1     Running   0          3m58s
istiod-7d645647-mh7fj                   1/1     Running   0          4m11s
```



# NAMESPACE ONBOARDING >>> DONE MANY TIMES
You have to labem namespace to notify istio about the place where to automatically inject sidecar istio-proxy for new pods  
If this label is added to the namespace then:
-Mutating Admission Webhook Istio takeover pod creation and add sidecar container with necessary settings


```
kubectl create namespace lab
kubectl label ns lab istio-injection=enabled --overwrite
```

# Install example application bookinfo


```
kubectl apply -n lab -f https://raw.githubusercontent.com/istio/istio/release-1.25/samples/bookinfo/platform/kube/bookinfo.yaml
```
