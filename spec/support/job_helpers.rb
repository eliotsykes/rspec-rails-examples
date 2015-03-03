# Use Rails-provided test helper methods

RSpec.configure do |config|
  config.include ActiveJob::TestHelper, type: :job
end

# Suggested docs
# --------------
# http://api.rubyonrails.org/classes/ActiveJob/TestHelper.html