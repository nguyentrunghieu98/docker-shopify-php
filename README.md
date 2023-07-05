# Docker Shopify - PHP

  docker build -t my-new-app --build-arg SHOPIFY_API_KEY=ba0d0cca03aadabbb2890e54dbce1f75 .

  docker run -d -v /home/hieu/Shopify/hello-liquid-app/web:/app -p 9000:80 --name shopify-php  hello-liquid-app


