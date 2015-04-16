# Setting up Custom Matchers:

# 0. Check spec/support dir is auto-required in spec/rails_helper.rb.
#
# 1. Create a file like this one you're reading in spec/support/matchers.rb:

Dir[Rails.root.join("spec/matchers/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include Matchers
end

# 2. Write custom matcher classes in spec/matchers/ directory
# 
#    Each matcher class will need to be in a module called 
#    "Matchers" to work with the RSpec configuration specified
#    above, see the spec/matchers directory for an example.

# Suggested docs
# --------------
# "Custom Matchers" section at http://www.rubydoc.info/gems/rspec-expectations/RSpec/Matchers
