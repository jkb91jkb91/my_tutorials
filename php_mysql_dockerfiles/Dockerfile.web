FROM mattrayner/lamp:latest
COPY /connect.php /app
COPY /index.php /app

CMD [ "apachectl", "-D", "FOREGROUND" ]

EXPOSE 80
