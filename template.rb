#
## Gems
#

gem_group :deployment do
  gem 'capistrano'
end

# Auth (authentication + authorization)
gem_group :auth do
  gem 'devise'
  gem 'cancan'
end

gem_group :maintenance do
  gem 'turnout'
end

gem_group :api do
  gem 'fog' # Access to multiple cloud services
end

gem_group :async_processing do
  # Some in-process ones to start
  # gem 'rufus-scheduler'
  # gem 'sucker_punch'
end

gem_group :ab_testing do
  # gem 'vanity'
end

gem_group :models do
  gem 'friendly_id' # URL slugs
  gem 'obfuscate_id' # Don't expose object ids to users
  gem 'better_serialization' # Replace Yaml serialization
end

gem_group :controllers do
  gem 'cocoon' # Nested objects forms
end

gem_group :views do
  gem 'meta-tags', :require => 'meta_tags'
  gem 'simple_form'
  gem 'will_paginate'
  gem 'breadcrumbs_on_rails'
  gem 'inherited_resources' # Cleaner controllers
end

gem_group :input do
  gem 'rails_autolink' # Sanitized html_safe strings with URLs + e-mails
end

gem_group :generators do
  # gem 'rabl' # JSON render-er
  gem 'sitemap_generator', :require => false
end

gem_group :monitoring do
  # gem 'nunes' # ActiveSupport::Notifications => statsd
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
  gem 'less-rails'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
  gem 'sprockets'
  gem 'sprockets-image_compressor'
  gem 'favicon_maker' # Hi and low res fav-icons for asset-pipeline
  gem 'asset_sync' # Move compiled assets off of app servers
end

gem_group :client_side do 
  gem 'jquery-rails'
  gem 'jquery-ui-rails'
  # gem 'jquery-fileupload-rails'
  
  gem 'less-rails-bootstrap'
  # vs. twitter-bootstrap-rails ?
end

gem_group :development_logging do
  gem 'quiet_assets'
  gem 'lograge'
end

gem_group :development_server do
  gem 'thin'
end

gem_group :development_mail do
  gem 'mailcatcher' # Fake SMTP/email client
end
  
gem_group :development_database do
  gem 'bullet' # Catch N+1 queries
end

gem_group :test do
  gem 'shoulda-matchers'
  gem 'email_spec'
  gem 'timecop'
  gem 'vcr' # For requests that are hard to mock.
  gem 'fakeweb'
end

gem_group :spec do
  gem 'rspec-rails'
end
  
gem_group :features do
  gem 'database_cleaner' # For use in features with multi-threaded JS tests
  gem 'capybara'
  gem 'puffing-billy', :require => 'billy' # Stubs for mock browsers
  gem 'poltergeist' # Requires PhantomJS installed via brew/etc.
end

gem_group :test, :development do
  # Dummy data
  gem 'factory_girl_rails'
  gem 'faker'
  
  # JS tests
  gem 'jasmine'
end

gem_group :console do
  gem 'pry-rails', :require => false
  gem 'pry-nav', :require => false
  gem 'awesome_print', :require => false
end

#
## Gem setup
#

# Initialize CanCan
run "bundle exec rails g cancan:ability"
run "bundle exec rspec:install"

inject_into_file "spec/spec_helper.rb", after: "RSpec.configure do |config|\n" do
  " config.include FactoryGirl::Syntax::Methods\n\n"
end

#
## Config changes
#

remove_file "README.rdoc"
create_file "README.md", "#{@app_name}"

database_yml = <<-DATABASE_YML
defaults: &defaults
username: rails
password:

development:
database: #{@app_name}_development
<<: *defaults

test: &test
database: #{@app_name}_test
<<: *defaults
DATABASE_YML

remove_file 'config/database.yml'
create_file 'config/database.yml', database_yml
create_file 'config/database.yml.example', database_yml

append_to_file '.gitignore', '/config/database.yml'

#
## Revision setup
#

git :init
git add: "."
git commit: %Q{ -m 'Initial commit' }
