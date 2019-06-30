# Rales Engine

## Project Description
This project uses Rails and ActiveRecord to build a JSON API which exposes the SalesEngine data schema.

## Setup
1. Clone repo to your local machine
```
git clone git@github.com:lpile/rales_engine_api.git
```
2. cd into rales_engine_api
```
cd rales_engine_api
```
3. Type in bundle install
```
bundle install
```
4. Type in bundle exec rake db:{drop,create,migrate} for database
```
bundle exec rake db:{drop,create,migrate}
```
5. Import csv files which will take awhile
```
rake import:data
```

## Learning Goals
* Learn how to to build Single-Responsibility controllers to provide a well-designed and versioned API.
* Learn how to use controller tests to drive your design.
* Use Ruby and ActiveRecord to perform more complicated business intelligence.

## Technical Expectations
* All endpoints will expect to return JSON data
* All endpoints should be exposed under an api and version (v1) namespace.
* Prices are in cents, therefore you will need to transform them in dollars. (12345 becomes 123.45)
