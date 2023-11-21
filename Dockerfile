# Step 1: Build the app in image 'builder'
FROM node:12.0.0-alpine AS builder

RUN npm config set unsafe-perm true
RUN npm config set registry https://registry.npm.taobao.org
RUN npm install -g @angular/cli

WORKDIR /usr/src/app
COPY tower-web .
RUN npm install  -y
RUN npm run build

# FROM adoptopenjdk/openjdk11 AS builderJ
# WORKDIR /usr/src/app
# COPY . .
# RUN ./gradlew assemble 

# Step 2: Use build output from 'builder'
FROM adoptopenjdk/openjdk11
# LABEL version="1.0"
RUN apt-get update &&  apt-get install nginx -y

WORKDIR /var/www/html/
COPY --from=builder /usr/src/app/dist/tower-web/ .

COPY nginx.conf /etc/nginx/sites-available/default
WORKDIR /app
COPY tower-backend/build/distributions/tower-backend-20.06.0.tar .
RUN tar xvf tower-backend-20.06.0.tar

WORKDIR /app/tower-backend-20.06.0/bin
COPY docker-entrypoint.sh  .
ENTRYPOINT ["./docker-entrypoint.sh"]

# ./gradlew assemble
#  docker build -t wangyang1749/nf-tower-web .
# docker login
# docker run --rm  -p 82:80  wangyang1749/nf-tower-web:latest
# docker image push  wangyang1749/nf-tower-web:latest










