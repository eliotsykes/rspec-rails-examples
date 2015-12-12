if Rails.env.development?
  User.create_with(password: 'password', confirmed_at: Time.zone.now).find_or_create_by!(email: 'a@a.a')
end
