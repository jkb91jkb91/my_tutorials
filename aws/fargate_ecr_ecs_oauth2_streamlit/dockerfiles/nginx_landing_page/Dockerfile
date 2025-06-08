FROM nginx:alpine

# curl REQUIRED FOR HEALTH CHECKS
RUN apk update && apk add --no-cache curl

# Skopiuj własną konfigurację NGINX
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Skopiuj aplikację (np. index.html i zasoby)
COPY html/ /usr/share/nginx/html/

EXPOSE 80
