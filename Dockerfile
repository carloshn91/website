# | Build
FROM node:alpine AS build
ENV APP_NAME website
ENV BUILD_NODEJS /srv/www/${APP_NAME}
RUN mkdir -p $BUILD_NODEJS 
WORKDIR $BUILD_NODEJS
COPY . .
RUN npm install && \
    npm run build

# | Frontend
FROM nginx:stable-alpine
RUN apk add --update --no-cache apache2-utils
ENV APP_NAME website
ENV FRONTEND_ROOT /var/www/${APP_NAME}
WORKDIR ${FRONTEND_ROOT}
COPY --from=build /srv/www/${APP_NAME}/build ${FRONTEND_ROOT}/build
COPY ./infrastructure/docker/default.conf /tmp/docker.nginx
RUN envsubst '$FRONTEND_ROOT' < /tmp/docker.nginx > /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]
