# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby '2.7.0'

gem 'i18n', '~> 1.8', '>= 1.8.11'

group :development do
  gem 'fasterer'
  gem 'pry'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'solargraph'
end

group :test do
  gem 'rspec', '~> 3.8'
  gem 'simplecov'
  gem 'simplecov-lcov'
end
