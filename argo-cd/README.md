
1. Install argocd CLI
```
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64
```
2. Create ns argocd   
```
kubectl create ns argocd
```
3. Install argo in kubernetes  
```
kubectl apply -f  https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml -n argocd
```
4. Crete SECRET with TOKEN to repo  
```
apiVersion: v1
kind: Secret
metadata:
  name: my-git-repo-secret
  namespace: argocd
  labels:
    argocd.argoproj.io/secret-type: repository
stringData:
  url: https://github.com/jkb91jkb91/my_tutorials.git
  username: jkb91jkb91
  password: ghp_GXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```
5. Create application in argocd namespace
```
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/jkb91jkb91/my_tutorials.git
    targetRevision: main
    path: argo-cd
  destination:
    server: https://kubernetes.default.svc
    namespace: production
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
```

6. Check if works
```
kubectl get application -n argocd
```

7. Change serviceType to LoadBalancer/Ingress or do port-forward
```
kubectl edit  svc/argocd-server -n argocd
```

8. Get initial password
```
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
```

9. Go to UI
admin: admin  
password: FROM_SECRET

10. Debugging
```
kubectl logs -n argocd -l app.kubernetes.io/name=argocd-application-controller
```

11. Deploy app with argocd
```
argocd login <SERVER
argocd app list

argocd app create app-2 --repo https://github.com/jkb91jkb91/my_tutorials.git --revision main --path argocd --dest-server https://kubernetes.default.svc --dest-namespace app-2 --sync-option CreateNamespace=true

argocd app sync app-2
```
