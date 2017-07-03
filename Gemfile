source 'https://rubygems.org'
ruby "2.4.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'haml-rails', '>= 0.9.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'devise', '~> 4.2.1'
gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'rails-assets-tether', '>= 1.1.0'
gem 'sprockets-rails', '>= 2.3.2'
gem 'sprockets', '~> 4.0.0.beta4'
gem 'babel-transpiler'
gem 'font-awesome-rails'
gem 'turbolinks', '~> 5.0.0'

group :production do
  gem 'browserify-rails'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails', '>= 4.5.0'
  gem 'capybara'
  gem 'poltergeist'
  gem 'database_cleaner'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
