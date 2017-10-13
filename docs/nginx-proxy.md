# Nginx-proxy

You can use `nginx-proxy` docker-compose in same docker network to resolve virtual hosts

Make `nginx-proxy` folder and use it.
Make files like this

### `nginx-conf/nginx.conf`
```conf
server {
    listen  80;
    server_name frontend.dev www.frontend.dev;

    access_log  /var/log/nginx/proxy-access.log;
    error_log   /var/log/nginx/proxy-error.log;

    location / {
        proxy_pass http://nginx:8080/;
        proxy_set_header   X-Real-IP $remote_addr;
        proxy_set_header   Host $http_host;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location ~ /\.(ht|svn|git) {
        deny all;
    }
}

server {
    listen  80;
    server_name backend.dev www.backend.dev;

    access_log  /var/log/nginx/proxy-access.log;
    error_log   /var/log/nginx/proxy-error.log;

    location / {
        proxy_pass http://nginx:8081/;
        proxy_set_header   X-Real-IP $remote_addr;
        proxy_set_header   Host $http_host;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location ~ /\.(ht|svn|git) {
        deny all;
    }
}
```

### `docker-compose.yml`
```yml
version: '2'
services:
  nginx-proxy:
    image: nginx:1.13.5-alpine
    restart: always
    ports:
      - "80:80"
    volumes:
      - ./nginx-conf:/etc/nginx/conf.d #nginx-conf
      - ./nginx-logs:/var/log/nginx #nginx-logs
networks:
  default:
    external:
      name: dockeryii2appadvanced_default
```

Use 
```
docker-compose -f nginx-proxy/docker-compose.yml up -d 
```
command after `docker-compose up -d` of main composition.