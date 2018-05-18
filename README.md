# README

## MovieData - A Ruby on Rails app utilizing the TMDB API

See the app in action on Heroku: https://secret-earth-61668.herokuapp.com/

Further info about the TMDB API may be found here: https://developers.themoviedb.org/3/getting-started/introduction

### Stack

* Ruby 2.3.6
* Ruby on Rails 5.2.0
* PostgreSQL

### How to use locally

To run the application you must run the following commands

- Gems: bundle install
- Database: `rails db:create`
- Database: `rails db:migrate`
- Create ENV: `export TMDB_API_KEY="YOUR_KEY_HERE"`
- Run the server `rails s`
