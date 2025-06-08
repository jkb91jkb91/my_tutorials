FROM nginx:alpine

# Skopiuj własną konfigurację NGINX
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Skopiuj aplikację (np. index.html i zasoby)
COPY html/ /usr/share/nginx/html/

EXPOSE 80
