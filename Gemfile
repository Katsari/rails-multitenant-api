source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

gem 'rails', '~> 6.1.4', '>= 6.1.4.1'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.2'
# Use Puma as the app server
gem 'puma', '~> 5.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
# Rack middleware for blocking & throttling abusive requests
gem 'rack-attack'

# Graphiti helps building Stylish Graph APIs using RESTful Resources
gem 'graphiti', '~> 1.3'
gem 'graphiti-rails'
gem 'vandal_ui'
gem 'responders', '~> 3.0'
gem 'kaminari', '~> 1.2'

# Row Level Security (RLS) gives your application a second line of defense when isolating data in a multi-tenant application
gem 'rls_rails', github: 'sbiastoch/rls_rails'
# ActiveRecord/Rails integration for multi-tenant databases, adds tenant context to your queries
gem 'activerecord-multi-tenant', '~> 1.1'

# Simple, multi-client and secure token-based authentication
gem 'devise', '~> 4.8'
gem 'devise_token_auth', '~> 1.2'

# Authorization library which restricts what resources a given user is allowed to access.
gem 'cancancan', '~> 3.3'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Testing tool for Ruby and Behaviour Driven Development
  gem 'rspec-rails', '~> 5.0.0'
  # Fixtures replacement for writing factories for Ruby tests
  gem 'factory_bot_rails', '~> 6.2'
  # Generates fake data to use in tests
  gem 'faker', '~> 2.19'
  # Spec helpers for Graphiti APIs
  gem 'graphiti_spec_helpers'
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'amazing_print', '~> 1.3'
  # RuboCop is a Ruby static code analyzer and code formatter
  # Just type rubocop in the project's folder
  gem 'rubocop', '~> 1.20', require: false
  gem 'rubocop-rails', '>= 2.11.3', require: false
end

group :test do
  # Shoulda Matchers provides RSpec compatible one-liners to test common Rails functionality
  gem 'shoulda-matchers', '~> 5.0'
  # Cleans the ActiveRecord test database
  gem 'database_cleaner-active_record', '~> 2.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
