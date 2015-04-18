# 18/Apr/2015
- Upgrade Rails from 4.2.0 to 4.2.1 https://github.com/eliotsykes/rspec-rails-examples/pull/44 (Ryan Wold)

# 17/Apr/2015
- Remove redundant `type:` option from feature specs https://github.com/eliotsykes/rspec-rails-examples/pull/41 (Vitaly Tatarintsev)

# 28/Mar/2015
- Introduced custom RSpec matcher
- Introduced chainable custom RSpec matcher

# 9/Mar/2015
- pry-rails installed to aid debugging in rails console

# 7/Mar/2015
- Introduce VCR to stub HTTP request in scraper job.

# 6/Mar/2015
- Add /share page as demo of testing 3rd party JavaScript dependencies
- puffing-billy proxies and removes test dependency on 3rd party JS

# 3/Mar/2015
- Introduced Job spec example involving web scraping and emailing
- Upgraded to Rails 4.2.0 (from 4.2.0-rc2)

# 17/Feb/2015
- Raise error if config.use_transactional_fixtures is true and explain db connections issue
- Configure JS-dependent spec browser driver to be Selenium, Chrome.

# 19/Jan/2015
- pry-rescue installed and noted in README
- Factory Girl's create_list & sequence examples
- RSpec example for testing Rake tasks
- RSpec examples for `expect { ... }.to change { ... }.from(int).to(int)`
- Using Rails' testing TimeHelpers (e.g. `travel_to`) in RSpec

# 3/Jan/2015
- Factory Girl added and documented
- DatabaseCleaner setup

# 13/Dec/2014
- Helper spec example added for testing the page title helpers

# 11/Dec/2014
- "Subscribe to newsletter" feature
- email_spec examples and setup
- shoulda-matchers setup and use
- Capybara setup and example use
- RSpec-rails setup and examples