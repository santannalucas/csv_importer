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

user@ubuntu:~/sentia$ bundle install

```

* Database creation

Application use PostgreSQL Database, configuration should look like this:

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

# Importer Requirements

 As a user, I should be able to upload this sample CSV and import the data into
a database.
 
 a. The data needs to load into 3 tables. People, Locations and
Affiliations

b. A Person can belong to many Locations

c. A Person can belong to many Affiliations

d. A Person without an Affiliation should be skipped

e. A Person should have both a first_name and last_name. All fields

need to be validated except for last_name, weapon and vehicle
which are optional.

f. Names and Locations should all be titlecased
 
* User Cases
  1. As a user, I should be able to view these results from the importer in a table.
  2. As a user, I should be able to paginate through the results so that I can see a
     maximum of 10 results at a time.
  3. As a user, I want to type in a search box so that I can filter the results I want to see.
  4. As a user, I want to be able to click on a table column heading to reorder the visible
     results.
  

* Assumptions

  1. Person First Name and Last Name will be used to find existing record and update if exist or create if it doesn't (UPSERT)
  2. Special Characters are allowed.
  3. Requirements says that a person should have both first and last name, but last_name is optional. So uniqueness was created for both. As result only one Person can have a name with no last_name.

