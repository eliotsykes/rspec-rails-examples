# How to test Rake tasks:

# 0. Check spec/support dir is auto-required in spec/rails_helper.rb.
#
# 1. Create a file like this one you're reading in spec/support/tasks.rb:
require "rake"

RSpec.configure do |config|
  
  config.before(:suite) do
    Rails.application.load_tasks
  end

end
