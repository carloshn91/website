FROM nginx:stable-alpine
RUN apk add --update --no-cache apache2-utils nodejs npm
ENV APP_NAME website
ENV FRONTEND_ROOT /var/www/${APP_NAME}
WORKDIR ${FRONTEND_ROOT}
COPY . .
COPY ./infrastructure/docker/default.conf /tmp/docker.nginx
RUN npm install && npm run build
RUN envsubst '$FRONTEND_ROOT' < /tmp/docker.nginx > /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]
