


# 1.) BOOSTRAP
Prerequisuites  
- kubectl  
- kind  
- docker  

boostrap.sh create initial setup  
- run localstack imitating AWS . 
- start kind cluster  
- install crossplane in cluster by the use of helm  
- install S3 provider  
- install SQS provider  
- create secret  
- install configuration for provider  
- install first managed resource: S3 bucket

# 2.) Check managed resource
```
kubectl get bucket
NAME                     READY   SYNCED   EXTERNAL-NAME            AGE
crossplane-test-bucket   True    True     crossplane-test-bucket   119m
```
