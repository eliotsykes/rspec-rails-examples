module LoginHelper

  def login(*args)
    if args.size == 1 && args[0].is_a?(User)
      user = args[0]
      email = user.email
      password = user.password
    elsif args.size == 2
      email, password = args
    else
      raise "Unable to handle args #{args.inspect}"
    end

    fill_in "Email", with: email
    fill_in "Password", with: password
    click_button "Log in"
  end

end

RSpec.configure do |config|
  config.include LoginHelper, type: :feature
end
