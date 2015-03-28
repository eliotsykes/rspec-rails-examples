RSpec Rails Examples
====================

Rails app with examples of how to test with RSpec and other testing gems.

<!-- MarkdownTOC depth=0 autolink=true bracket=round -->

- [Testing Rake Tasks with RSpec](#testing-rake-tasks-with-rspec)
- [Pry-rescue debugging](#pry-rescue-debugging)
- [Time Travel Examples](#time-travel-examples)
- [ActiveJob Examples](#activejob-examples)
- [Database Cleaner Examples](#database-cleaner-examples)
- [Factory Girl Examples](#factory-girl-examples)
- [VCR Examples](#vcr-examples)
- [Capybara Examples](#capybara-examples)
- [Puffing Billy Examples](#puffing-billy-examples)
- [Shoulda-Matchers Examples](#shoulda-matchers-examples)
- [Email-Spec Examples](#email-spec-examples)
- [Devise Examples](#devise-examples)
- [Custom Matchers](#custom-matchers)
- [RSpec-Expectations Docs](#rspec-expectations-docs)
- [RSpec-Mocks Specs & Docs](#rspec-mocks-specs--docs)
- [RSpec-Rails](#rspec-rails)
  - [Matchers](#matchers)
  - [Generators](#generators)
  - [Feature Specs & Docs](#feature-specs--docs)
  - [Mailer Specs & Docs](#mailer-specs--docs)
  - [Controller Specs & Docs](#controller-specs--docs)
  - [Helper Specs & Docs](#helper-specs--docs)
  - [Routing Specs & Docs](#routing-specs--docs)
- [Contributors](#contributors)

<!-- /MarkdownTOC -->

# Testing Rake Tasks with RSpec

RSpec testing Rake task configuration and example:
- [spec/support/tasks.rb](spec/support/tasks.rb)
- [spec/tasks/subscription_tasks_spec.rb](spec/tasks/subscription_tasks_spec.rb)

# Pry-rescue debugging
pry-rescue can be used to debug failing specs, by opening pry's debugger whenever a test failure is encountered. For setup and usage see [pry-rescue's README](https://github.com/ConradIrwin/pry-rescue).


# Time Travel Examples

[`ActiveSupport::Testing::TimeHelpers`](http://api.rubyonrails.org/classes/ActiveSupport/Testing/TimeHelpers.html) provides helpers for manipulating and freezing the current time reported within tests. These methods are often enough to replace the time-related testing methods that the `timecop` gem is used for.

`TimeHelpers` configuration how-to and examples:
- [spec/support/time_helpers.rb](spec/support/time_helpers.rb)
- [spec/models/subscription_spec.rb](spec/models/subscription_spec.rb)
- [spec/tasks/subscription_tasks_spec.rb](spec/tasks/subscription_tasks_spec.rb)
- [`travel_to`](http://api.rubyonrails.org/classes/ActiveSupport/Testing/TimeHelpers.html#method-i-travel_to) example: [spec/models/subscription_spec.rb](spec/models/subscription_spec.rb)
- [`ActiveSupport::Testing::TimeHelpers` API documentation](http://api.rubyonrails.org/classes/ActiveSupport/Testing/TimeHelpers.html)


# ActiveJob Examples

[`ActiveJob::TestHelper`](http://api.rubyonrails.org/classes/ActiveJob/TestHelper.html) provides help to test ActiveJob jobs.

`ActiveJob::TestHelper` configuration how-to and examples:
- [spec/support/job_helpers.rb](spec/support/job_helpers.rb)
- [spec/jobs/headline_scraper_job_spec.rb](spec/jobs/headline_scraper_job_spec.rb)
- [`ActiveJob::TestHelper` API documentation](http://api.rubyonrails.org/classes/ActiveJob/TestHelper.html)


# Database Cleaner Examples

[Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner) is a set of strategies for cleaning your database in Ruby, to ensure a consistent environment for each test run.

Database Cleaner configuration how-to:
- [spec/support/database_cleaner.rb](spec/support/database_cleaner.rb)


# Factory Girl Examples

[Factory Girl](https://github.com/thoughtbot/factory_girl) is a library to help setup test data. [factory_girl_rails](https://github.com/thoughtbot/factory_girl_rails) integrates Factory Girl with Rails.

Factory Girl configuration how-to and examples:
- [spec/support/factory_girl.rb](spec/support/factory_girl.rb)
- [spec/factories](spec/factories)
- [spec/factories/users.rb](spec/factories/users.rb)
- [spec/models/subscription_spec.rb](spec/models/subscription_spec.rb)
- [spec/tasks/subscription_tasks_spec.rb](spec/tasks/subscription_tasks_spec.rb)
- [spec/features/user_login_and_logout_spec.rb](spec/features/user_login_and_logout_spec.rb)


# VCR Examples

[VCR](https://github.com/vcr/vcr) records your test suite's HTTP interactions and replays them during future test runs. Your tests can run independent of a connection to external URLs. These HTTP interactions are stored in cassette files.

VCR configuration how-to and examples:
- [spec/support/vcr.rb](spec/support/vcr.rb)
- [spec/jobs/headline_scraper_job_spec.rb](spec/jobs/headline_scraper_job_spec.rb)
- [Cassette files in spec/support/http_cache/vcr](spec/support/http_cache/vcr)
- [VCR Relish docs](https://relishapp.com/vcr/vcr/docs)
- [VCR API docs](http://www.rubydoc.info/gems/vcr/frames)

# Capybara Examples

[Capybara](https://github.com/jnicklas/capybara) helps you write feature specs that interact with your app's UI as a user does with a browser.

Capybara configuration how-to and examples:
- [spec/support/capybara.rb](spec/support/capybara.rb)
- [spec/features/home_page_spec.rb](spec/features/home_page_spec.rb)
- [spec/features/subscribe_to_newsletter_spec.rb](spec/features/subscribe_to_newsletter_spec.rb)
- [spec/features/user_login_and_logout_spec.rb](spec/features/user_login_and_logout_spec.rb)
- [spec/features/user_registers_spec.rb](spec/features/user_registers_spec.rb)
- [Capybara cheatsheet](https://gist.github.com/zhengjia/428105)
- [Capybara matchers](http://www.rubydoc.info/github/jnicklas/capybara/master/Capybara/Node/Matchers)


# Puffing Billy Examples

[Puffing Billy](https://github.com/oesmith/puffing-billy) is like VCR for browsers used by feature specs. Puffing Billy is a HTTP proxy between your browser and external sites, including 3rd party JavaScript. If your app depends on JavaScript hosted on another site, then Puffing Billy will keep a copy of that JavaScript and serve it from a local web server during testing. This means tests dependent on that JavaScript will carry on working even if the original host cannot be connected to.

If you need to debug Puffing Billy, refer to its output in `log/test.log`.

Puffing Billy configuration how-to and examples:
- [spec/support/puffing_billy.rb](spec/support/puffing_billy.rb)
- [spec/features/share_page_spec.rb](spec/features/share_page_spec.rb)
- [Cache options](https://github.com/oesmith/puffing-billy#caching)
- [Cached responses in spec/support/http_cache/billy](spec/support/http_cache/billy)


# Shoulda-Matchers Examples

[Shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers) make light work of model specs.

shoulda-matchers configuration how-to and examples:
- [spec/support/shoulda_matchers.rb](spec/support/shoulda_matchers.rb)
- [spec/models/subscription_spec.rb](spec/models/subscription_spec.rb)


# Email-Spec Examples

The "Subscribe to newsletter" feature was developed with help from [email_spec](https://github.com/bmabey/email-spec)

email_spec configuration how-to and examples:
- [spec/support/email_spec.rb](spec/support/email_spec.rb)
- [spec/jobs/headline_scraper_job_spec.rb](spec/jobs/headline_scraper_job_spec.rb)
- [spec/mailers/news_mailer_spec.rb](spec/mailers/subscription_mailer_spec.rb)
- [spec/mailers/subscription_mailer_spec.rb](spec/mailers/subscription_mailer_spec.rb)
- [spec/features/subscribe_to_newsletter_spec.rb](spec/features/subscribe_to_newsletter_spec.rb)
- [spec/features/user_registers_spec.rb](spec/features/user_registers_spec.rb)
- [`EmailSpec::Helpers` API documentation](http://www.rubydoc.info/gems/email_spec/EmailSpec/Helpers)
- [`EmailSpec::Matchers` API documentation](http://www.rubydoc.info/gems/email_spec/EmailSpec/Matchers)


# Devise Examples

Specs testing registration, sign-in, and other user authentication features provided by Devise:

- [spec/features/user_login_and_logout_spec.rb](spec/features/user_login_and_logout_spec.rb)
- [spec/features/user_registers_spec.rb](spec/features/user_registers_spec.rb)


# Custom Matchers

You can write your own custom RSpec matchers. Custom matchers can help you write more understandable
specs.

Custom matchers configuration how-to and examples:
- [spec/support/matchers.rb](spec/support/matchers.rb)
- [spec/matchers](spec/matchers)
- [spec/matchers/be_pending_subscription_page.rb](spec/matchers/be_pending_subscription_page.rb)
- [spec/features/subscribe_to_newsletter_spec.rb](spec/features/subscribe_to_newsletter_spec.rb)


# RSpec-Expectations Docs
- [RSpec-Expectations API](http://www.rubydoc.info/gems/rspec-expectations/frames)
- [RSpec-Expectations matchers](https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers)


# RSpec-Mocks Specs & Docs
- [spec/controllers/subscriptions_controller_spec.rb](spec/controllers/subscriptions_controller_spec.rb)
- [spec/mailers/subscription_mailer_spec.rb](spec/mailers/subscription_mailer_spec.rb)
- [spec/models/subscription_spec.rb](spec/models/subscription_spec.rb)
- [RSpec Mocks API](https://relishapp.com/rspec/rspec-mocks/v/3-1/docs)

# RSpec-Rails
See [RSpec Rails](https://relishapp.com/rspec/rspec-rails/v/3-1/docs) for installation instructions.

## Matchers
- https://relishapp.com/rspec/rspec-rails/v/3-1/docs/matchers

## Generators
- https://relishapp.com/rspec/rspec-rails/v/3-1/docs/generators

## Feature Specs & Docs
- [spec/features/subscribe_to_newsletter_spec.rb](spec/features/subscribe_to_newsletter_spec.rb)
- [Feature specs API](https://relishapp.com/rspec/rspec-rails/v/3-1/docs/feature-specs/feature-spec)

## Mailer Specs & Docs
- [spec/mailers/subscription_mailer_spec.rb](spec/mailers/subscription_mailer_spec.rb)
- [Mailer specs API](https://relishapp.com/rspec/rspec-rails/v/3-1/docs/mailer-specs/url-helpers-in-mailer-examples)

## Controller Specs & Docs
- [spec/controllers/subscriptions_controller_spec.rb](spec/controllers/subscriptions_controller_spec.rb)
- [Controller specs API](https://relishapp.com/rspec/rspec-rails/v/3-1/docs/controller-specs)
- [Controller specs cheatsheet](https://gist.github.com/eliotsykes/5b71277b0813fbc0df56)

## Helper Specs & Docs
- [spec/helpers/application_helper_spec.rb](spec/helpers/application_helper_spec.rb)
- [Helper specs API](https://relishapp.com/rspec/rspec-rails/v/3-1/docs/helper-specs/helper-spec)

## Routing Specs & Docs
- [spec/routing/subscriptions_routing_spec.rb](spec/routing/subscriptions_routing_spec.rb)
- [Routing specs API](https://relishapp.com/rspec/rspec-rails/v/3-1/docs/routing-specs)


---

# Contributors

- Eliot Sykes https://eliotsykes.com/
- Your name here, contributions are welcome and easy! Just fork the GitHub repo, make your changes, then submit your pull request!

