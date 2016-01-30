# To enable recording HTTP interactions temporarily, run the 
# individual spec and prepend with RECORD set to true, e.g.:
# RECORD=true bin/rspec spec/features/user_upgrades_spec.rb

module HttpRecord
  def self.off?
    !on?
  end
  
  def self.on?
    'true' == ENV['RECORD']
  end
end
