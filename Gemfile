source 'https://rubygems.org'

ruby "2.2.1"

gem 'unicorn', '~> 4.9'

#background processing
gem 'sidekiq', '~> 4.0.1'

gem 'redis-rails', '~> 4.0.0'

#CSV gem
gem 'spreadsheet'

#Elasticsearch gem
gem 'elasticsearch-model'
gem 'elasticsearch-rails'

# Use postgres as the database for Active Record
gem 'pg', '~> 0.18.3'

# Geocoding gem
gem 'geocoder'

#Api documentation 
gem 'apipie-rails'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
gem 'figaro'

gem "health_check"


group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem "factory_girl_rails", "~> 4.0"
  gem 'database_cleaner'
  gem 'pry'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  #gem 'spring'
  gem 'shoulda'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'mailcatcher'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :production do
  gem 'rails_12factor'
end

