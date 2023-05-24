#!/bin/bash

curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
service docker start # 如果docker没启动，可以运行这个
# docker创建网络
docker network create cdntip_network

# 启动mysql容器
mkdir /data docker run -d -it --network cdntip_network --restart=always -v /data/mysql:/var/lib/mysql --name panel_mysql -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=panel mysql:5.7 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci

# 启动 cloudpanel
docker run -d -it --network cdntip_network -p 80:80 --name panel cdntip/panel

# 进入容器

docker exec -it panel /bin/bash

python manage.py createsuperuser --username admin --email admin@admin.com
admin
admin


python manage.py aws_update_images
