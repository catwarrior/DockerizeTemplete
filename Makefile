pull:
	docker pull nginx:1.9.0
	docker pull php:5.6-fpm
	docker pull mysql:5.6

dl:
	wget https://pecl.php.net/get/xdebug-2.3.2.tgz -O php/xdebug.tgz

build:
	make build-nginx
	make build-mysql
	make build-php

build-nginx:
	docker build -t eva/nginx ./nginx

run-nginx:
	docker run -i -d -p 80:80 -v ~/opt:/opt -t fad/nginx

in-nginx:
	docker run -i -p 80:80 -v ~/opt:/opt -t eva/nginx /bin/bash

build-php:
	docker build -t eva/php ./php

run-php:
	docker run -i -d -p 9000:9000 -v ~/opt:/opt -t fad/php

in-php:
	docker run -i -p 9000:9000 -v ~/opt:/opt -t fad/php /bin/bash

build-mysql:
	docker build -t eva/mysql ./mysql

run-mysql:
	docker run -i -d -p 3306:3306 -v ~/opt/data/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -t fad/mysql

in-mysql:
	docker run -i -p 3306:3306  -v ~/data/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -t eva/mysql /bin/bash

clean:
	docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")
