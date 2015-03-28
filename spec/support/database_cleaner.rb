# Installing database_cleaner:

# 1. Add database_cleaner to Gemfile:
#
# group :test do
#   gem 'database_cleaner'
# end

# 2. IMPORTANT! Delete the "config.use_transactional_fixtures = ..." line 
#    in spec/rails_helper.rb (we're going to configure it in this file you're
#    reading instead).

# 3. Create a file like this one you're reading in spec/support/database_cleaner.rb:
RSpec.configure do |config|

  config.use_transactional_fixtures = false
  
  config.before(:suite) do
    if config.use_transactional_fixtures?
      
      raise(<<-MSG)

        Delete line `config.use_transactional_fixtures = true` from rails_helper.rb
        (or set it to false) to prevent uncommitted transactions being used in
        JavaScript-dependent specs.

        During testing, the Ruby app server that the JavaScript browser driver
        connects to uses a different database connection to the database connection
        used by the spec.
        
        This Ruby app server database connection would not be able to see data that
        has been setup by the spec's database connection inside an uncommitted
        transaction.

        Disabling the use_transactional_fixtures setting helps avoid uncommitted
        transactions in JavaScript-dependent specs, meaning that the Ruby app server
        database connection can see any data set up by the specs.

      MSG

    end
  end
  
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    if Capybara.current_driver == :rack_test
      # :rack_test driver's Rack app under test shares database connection
      # with the specs, so we can use transaction strategy for speed.
      DatabaseCleaner.strategy = :transaction
    else
      # Non-:rack_test driver is probably a driver for a JavaScript browser
      # with a Rack app under test that does *not* share a database 
      # connection with the specs, so we must use truncation strategy.
      DatabaseCleaner.strategy = :truncation
    end
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end

# Suggested docs
# --------------
# http://devblog.avdi.org/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/

