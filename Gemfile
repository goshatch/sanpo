source 'http://rubygems.org'

gem 'rails', '3.2.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3', "~> 1.3.5"


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'haml', "~> 3.1.4"
gem 'haml-rails', :group => :development
gem 'coffee-filter' # Coffeescript in HAML files

gem "paperclip", "~> 2.4"
gem "best_in_place", :git => "git://github.com/bernat/best_in_place.git"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'
gem 'capistrano_colors'

# User authentication
gem "devise", "~> 2.0.0"
gem "oa-oauth", :require => "omniauth/oauth"

# Geocoding
gem "geocoder", :git => "git://github.com/alexreisner/geocoder.git"

group :development, :test do
  # # To use debugger
  # gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rb-fsevent', :require => false
  gem 'growl', :require => false
  gem 'guard-rspec'
  gem 'guard-livereload'
end

# Background jobs
gem "delayed_job", "~> 3.0.1"
gem "delayed_job_active_record", "~> 0.3.2"
gem 'delayed_job_web'
gem 'daemons'

# Postmark
gem 'postmark'
gem 'postmark-rails', '0.4.0'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem "factory_girl"
  gem "factory_girl_rails"
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'headless'
end

group :production do
  gem 'mysql2'
end
