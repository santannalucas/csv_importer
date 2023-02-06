# README

CSV to SQL

* Ruby version

This app uses Ruby 3.0.0 and Rails ~> 7.0, be sure to change you version manager to version 3 and that you have rails 7 installed:

```shell
user@ubuntu:~/sentia$ rvm use ruby-3.0.0
Using /home/user/.rvm/gems/ruby-3.0.0

user@ubuntu:~/sentia$ ruby -v
ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-linux]

user@ubuntu:~/sentia$ rails -v
Rails 7.0.4.2

```

* Database creation

Application use PostgreSQL Database by default, configuration should look like this:

```yml
# PostgreSQL 10

default: &default
  adapter: postgresql
  host: localhost
  username: lucas
  password: password

production:
  <<: *default
  database: exercise

development:
  <<: *default
  database: exercise_dev

test:
  <<: *default
  database: exercise_test
```

* Database initialization

```shell
rake db:create
rake db:migrate
```