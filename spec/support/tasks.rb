require "rake"

RSpec.configure do |config|
  
  config.before(:suite) do
    Rails.application.load_tasks
  end

end
