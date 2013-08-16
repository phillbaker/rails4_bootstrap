#
## Gems
#

gem_group :maintenance do
  gem 'turnout', :git => 'git://github.com/phillbaker/turnout.git', :branch => 'fix-remove-require' #:path => '../turnout' # has a silly require 'active_record'...
end

gem_group :security do
  gem 'devise' # Authentication
  gem 'cancan' # Authorization via roles
end

gem_group :rails_helpers do
  gem 'obfuscate_id' # Don't expose DB id's to users
  # gem 'friendly_id' # URL slugs

  gem 'simple_form'
  # gem 'cocoon' # Nested models
  gem 'breadcrumbs_on_rails'
  gem 'inherited_resources' # Cleaner controllers
  gem 'rails_autolink' # View helper for sanitized html_safe strings with URLs + e-mails
end

gem_group :uploads do
  # gem 'carrierwave' # Or paperclip
  # gem 'mini_magick' # Must be installed on box
end

# Gems used only for assets and not required
# in production environments by default.
gem_group :assets do
  gem 'csso-rails' # CSS Optimizer
  gem 'coffee-rails'
  gem 'less-rails' # Do before sass-rails so that scaffolding is done with less
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platforms: :ruby
  gem 'uglifier', '>= 1.0.3'
  gem 'sprockets'
  gem 'sprockets-image_compressor'
end

gem_group :client_side do 
  gem 'jquery-rails'
  gem 'jquery-ui-rails'
  gem 'rails-backbone'
  gem 'jquery-fileupload-rails'
  
  gem 'less-rails-bootstrap'
  # vs. twitter-bootstrap-rails ?
end

gem_group :development do
  # Logging
  gem 'quiet_assets'
  gem 'lograge'
  
  # Server
  gem 'thin'
  
  # Fake SMTP/email client
  gem 'mailcatcher'
  
  gem 'bullet' # Avoid N+1 queries
end

gem_group :test do
  gem 'shoulda-matchers'
  gem 'email_spec'
  gem 'timecop'
  gem 'vcr'

  # Cucumber feature tests
  gem 'cucumber-rails', require: false
  gem 'database_cleaner' # For use in cucumber with multi-threaded JS tests
  gem 'capybara'
  gem 'poltergeist'             # Requires PhantomJS installed via brew/etc.
end

gem_group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'jasmine'
end

#
## Gem setup
#

#
## Config changes
#

#
## Revisions setup
#
