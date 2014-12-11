RSpec.configure do |config|

  config.include EmailSpec::Helpers, [type: :mailer, type: :feature]
  config.include EmailSpec::Matchers, [type: :mailer, type: :feature]

end