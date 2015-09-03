# 0. Check spec/support dir is auto-required in spec/rails_helper.rb.
#
# You probably don't need this config, its for setting up Capybara drivers
# with descriptive names related to the underlying browser's HTML5 support.
module CapybaraDriverResolver

  FIREFOX_DRIVERS   = [:selenium_billy, :selenium]
  CHROME_DRIVERS    = [:selenium_chrome_billy]
  PHANTOMJS_DRIVERS = [:poltergeist_billy, :poltergeist]

  WITH_NATIVE_DATE_INPUT    = PHANTOMJS_DRIVERS + CHROME_DRIVERS
  WITHOUT_NATIVE_DATE_INPUT = FIREFOX_DRIVERS

  def driver_with(options)

    potential_drivers = options[:native_date_input] ? WITH_NATIVE_DATE_INPUT : WITHOUT_NATIVE_DATE_INPUT

    potential_drivers.each do |driver|
      return driver if Capybara.drivers[driver]
    end

    raise Capybara::DriverNotFoundError,
      "no driver matching options #{options.inspect} was found, available drivers: #{Capybara.drivers.join(', ')}"
  end

end

RSpec.configure do |config|
  config.extend CapybaraDriverResolver, type: :feature
end
