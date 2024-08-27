# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.3', '>= 7.1.3.4'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[ mri windows ]

  gem 'faker'

  gem 'mailcatcher', '~> 0.2.4'

  # This gem shall be installed as without this we are getting
  # compilation error like shown below
  # An error occurred while installing thin (1.6.2), and Bundler cannot
  # continue.
  #
  # In Gemfile:
  #   mailcatcher was resolved to 0.2.4, which depends on
  #     skinny was resolved to 0.2.4, which depends on
  #       thin
  # Hence as dependency with thin is needed we have to install it separately
  gem 'thin', '~> 1.8', '>= 1.8.2'

  # Money-rails: Integrates the Money gem with Rails
  # Provides a comprehensive solution for handling money and currency conversions
  gem 'money-rails'

  # A gem that calculates the exchange rate using published rates from open-exchange-rates
  gem 'money-open-exchange-rates'
end

gem 'rack-cors'

gem 'devise', '~> 4.9'
gem 'jsonapi-serializer'
gem 'devise-jwt'
