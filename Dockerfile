FROM php:8.1-fpm-alpine

ARG SHOPIFY_API_KEY
ENV SHOPIFY_API_KEY=$SHOPIFY_API_KEY

ENV SHOPIFY_API_KEY=ac989c568e6960c1fa2e24e553daf74d
ENV SHOPIFY_API_SECRET=8a6311666815ee6ada3e240271b0e20f
ENV SCOPES=write_products
ENV HOST=https://c57b-222-252-27-56.ngrok-free.app
ENV BACKEND_PORT=80

EXPOSE 80

EXPOSE 3456

RUN apk update && apk add --update nodejs npm \
    composer php-pdo_sqlite php-pdo_mysql php-pdo_pgsql php-simplexml php-fileinfo php-dom php-tokenizer php-xml php-xmlwriter php-session \
    openrc bash nginx

RUN docker-php-ext-install pdo

COPY --chown=www-data:www-data web /app
WORKDIR /app

# Overwrite default nginx config
COPY web/nginx.conf /etc/nginx/nginx.conf

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# RUN composer install
RUN touch /app/storage/db.sqlite
RUN chown www-data:www-data /app/storage/db.sqlite

RUN cd frontend && npm install && npm run build
RUN composer build

ENTRYPOINT [ "/app/entrypoint.sh" ]


