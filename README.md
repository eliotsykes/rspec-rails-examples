RSpec Rails Examples
====================

Rails app with examples of how to test with RSpec and other testing gems.

<!-- MarkdownTOC depth=0 autolink=true bracket=round -->

- [Capybara Examples](#capybara-examples)
- [Shoulda-Matchers Examples](#shoulda-matchers-examples)
- [Email-Spec Examples](#email-spec-examples)
- [RSpec-Expectations Docs](#rspec-expectations-docs)
- [RSpec-Mocks Specs & Docs](#rspec-mocks-specs--docs)
- [RSpec-Rails](#rspec-rails)
  - [Matchers](#matchers)
  - [Generators](#generators)
  - [Feature Specs & Docs](#feature-specs--docs)
  - [Mailer Specs & Docs](#mailer-specs--docs)
  - [Controller Specs & Docs](#controller-specs--docs)
  - [Routing Specs & Docs](#routing-specs--docs)

<!-- /MarkdownTOC -->


# Capybara Examples

[Capybara](https://github.com/jnicklas/capybara) helps you write feature specs that interact with your app's UI as a user does with a browser.

Capybara configuration how-to and examples:
- [spec/support/shoulda-matchers.rb](spec/support/capybara.rb)
- [spec/features/subscribe_to_newsletter_spec.rb](spec/features/subscribe_to_newsletter_spec.rb)


# Shoulda-Matchers Examples

[Shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers) make light work of model specs.

shoulda-matchers configuration how-to and examples:
- [spec/support/shoulda-matchers.rb](spec/support/shoulda-matchers.rb)
- [spec/models/subscription_spec.rb](spec/models/subscription_spec.rb)


# Email-Spec Examples

The "Subscribe to newsletter" feature was developed with help from [email_spec](https://github.com/bmabey/email-spec)

email_spec configuration how-to and examples:
- [spec/support/email_spec.rb](spec/support/email_spec.rb)
- [spec/features/subscribe_to_newsletter_spec.rb](spec/mailers/subscription_mailer_spec.rb)
- [spec/mailers/subscription_mailer_spec.rb](spec/mailers/subscription_mailer_spec.rb)


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

## Routing Specs & Docs
- [spec/routing/subscriptions_routing_spec.rb](spec/routing/subscriptions_routing_spec.rb)
- [Routing specs API](https://relishapp.com/rspec/rspec-rails/v/3-1/docs/routing-specs)
