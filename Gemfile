source 'https://rubygems.org'

gem 'rails', '4.2.3'

gem 'coffee-rails', '~> 4.1.0'
gem 'devise'
gem 'jquery-rails'
gem 'nokogiri'
gem 'sass-rails', '~> 4.0'
gem 'sqlite3'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'
gem 'symmetric-encryption', '~> 3.8.1'

gem 'quiet_assets', group: :development

group :development, :test do
  gem 'byebug' # Call 'byebug' in code to stop execution and get a debugger console
  gem 'capybara'
  # gem 'chromedriver-helper' # helps with using Chrome in feature specs
  gem 'factory_girl_rails', '~> 4.5'
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'puffing-billy'
  gem 'rspec-rails', '~> 3.2'
  gem 'selenium-webdriver' # used by JavaScript-dependent feature specs (`js: true`)
  gem 'spring' # Spring background-runs app in dev for speed
  gem 'spring-commands-rspec' # Enable Spring for RSpec
  gem 'web-console', '~> 2.0' # Access IRB on error pages or by <%= console %> in views
end

group :test do
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'poltergeist' # helps with using PhantomJS headless browser in feature specs
  gem 'shoulda-matchers', '3.0.0.rc1'
  gem 'vcr'
  gem 'webmock'
end
