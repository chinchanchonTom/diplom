FROM nginx:1.27.0

ADD conf /etc/nginx

ADD content /usr/share/nginx/html

EXPOSE 80
