FROM nginx:alpine

# curl REQUIRED FOR HEALTH CHECKS
RUN apk update && apk add --no-cache curl

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY html/ /etc/nginx/html/

EXPOSE 80
