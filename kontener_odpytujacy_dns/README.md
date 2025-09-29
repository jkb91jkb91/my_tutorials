ITS Additional container used as seperate ECS SERVICE  

ONE ECS SERVICE for all others services used to:  
-make GET requests to check if DOMAIN is achievable in this way  

Why to use such solution ??  
Lets say we have ALB and 2 ECS cointaners ( ALB > oauth-container > app-container)  
IF script from monitoring container will send GET REQUEST >>> it check whole traffic  
REQUEST FROM OUTSIDE >>>> ALB >>> ECS1 CONTAINER >> ECS2 CONTAINER



IMPORTANT POINT RELATED TO LOGS IN ECS AND REDIRECTING THEM TO STDOUT  
Use python -u  # without -u you will have problems with redirection of logs into ECS LOGS ( CLOUDWATCH )

```
python script.py Domyślnie buforuje wyjście, czyli np. print() może nie pojawić się od razu w logach  
python -u  script.py Wyłącza buforowanie – wszystko co wypiszesz przez print() pojawia się natychmiast  
```

```
FROM python:3.12-alpine

RUN apk add --no-cache curl \
  && pip install requests
  
WORKDIR /app

COPY entrypoint.py .
COPY targets.conf .

RUN chmod 0755 entrypoint.py
RUN chmod 0644 targets.conf
ENTRYPOINT ["python", "-u", "entrypoint.py"]
```
