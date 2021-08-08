# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

ruby-2.7.4

* System dependencies

Могут возникнуть проблемы при устнавкке гема `mysql2` на macOS при использовании rbenv. Решенние:
```shell
gem install mysql2 -v '0.5.3'  --source 'https://rubygems.org/' -- --with-cppflags=-I/usr/local/opt/openssl/include --with-ldflags=-L/usr/local/opt/openssl/lib
```

* Configuration

* Database creation

* Database initialization

* How to run the test suite

Фреймворка тестироваия - RSpec
```shell
rspec
```
Линтеры - Rubocop и Fasterer
```shell
rubocop

rubocop --require rubocop-performance

fasterer
```
* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
