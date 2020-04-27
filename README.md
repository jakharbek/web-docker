Docker for WEB
==========
Docker for WEB (docker-swarm + stack, registry, version,build (semver),proxy,php + node, nginx,postgres,mysql,redis,rabbitmq,supervizord + cron,mailcatcher,phpmyadmin,swagger,elk (elasticsearch,logstash,kibana),mongo + mongo-express)

Installation
------------

The preferred way to install this extension is through [composer](http://getcomposer.org/download/).

Either run

```
composer create-project jakharbek/web-docker
```


Docker
-----

Для начало вам нужно скопировать файл .env.example и переименовать в .env

Потом запольнить всё как вам нужно для работе после вы можете запустить docker-compose

```php
docker-compose up -d
```

Gitlab CI
-----

Для работы с Gitlab CI вам нужно заполнить все переменные среды в гитлаб. Пример в файле .env.gitlab.example

PHP CS
-----
По умолчанию указано на /application

```
php-cs-fixer fix --config .php_cs
```