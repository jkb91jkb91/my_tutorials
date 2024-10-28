# INSTRUCTION
IT IS BETTER TO RUN GITLAB NATIVELY ON THE SERVER INSTEAD OF DOCKER CONTAINER BECAUSE OF COMPLICITY  
https://docs.google.com/document/d/1Ce-coLXGtkiDiGp8Rr61So68M4Dfhtp0
Default files will be here  

```
Dane: /var/opt/gitlab/  
Logi: /var/log/gitlab/  

```

Configuration file
```
/etc/gitlab/gitlab.rb
```

SET THIS AFTER INSTALLATION >> HTTPS REQUIRED

```
external_url "https://projectdevops.eu"
nginx['ssl_certificate'] = "/etc/gitlab/ssl/projectdevops.eu.crt"
nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/projectdevops.eu.key"
nginx['listen_https'] = true
letsencrypt['enable'] = true
letsencrypt['contact_emails'] = ['twoj_email@domena.com'] # Podaj swój e-mail
letsencrypt['auto_renew'] = true
nginx['ssl_protocols'] = "TLSv1.2 TLSv1.3"
nginx['ssl_ciphers'] = "HIGH:!aNULL:!MD5"
```

INSTALACJA  
```
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash
sudo EXTERNAL_URL="http://localhost" apt-get install gitlab-ee

login: root
pass: sudo cat /etc/gitlab/initial_root_password

```
