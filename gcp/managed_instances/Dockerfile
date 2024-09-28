# Użyj oficjalnego obrazu nginx
FROM nginx:alpine

# Usuń domyślną stronę nginx
RUN rm /usr/share/nginx/html/index.html

# Skopiuj własną stronę HTML do katalogu nginx
COPY index.html /usr/share/nginx/html/

# Eksponuj port 80
EXPOSE 80

# Uruchom serwer nginx
CMD ["nginx", "-g", "daemon off;"]

