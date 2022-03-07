FROM nginx:1.21

COPY dist/horizon-webapp/ /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

CMD /bin/bash -c "nginx -g 'daemon off;'"
# When the container starts, replace the app-config.json with values from environment variables
CMD ["/bin/sh",  "-c",  "envsubst < /usr/share/nginx/html/assets/config/app-config.template.json > /usr/share/nginx/html/assets/config/app-config.json && exec nginx -g 'daemon off;'"]
