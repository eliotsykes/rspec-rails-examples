class TokenGuardian

  attr_reader :encryptor, :params

  def self.build(controller:)
    # Borrow MessageEncryptor, thank you CookieJar.
    encryptor = controller.request.cookie_jar.encrypted.instance_variable_get :@encryptor
    TokenGuardian.new(encryptor: encryptor, params: controller.params)
  end

  def initialize(encryptor:, params:)
    @encryptor = encryptor
    @params = params
  end

  def issue_token
    user = authenticate_user
    access_token = user.issue_access_token
    encryptor.encrypt_and_sign(access_token.unencrypted)
  end

  private

  def authenticate_user
    authenticate_user_with_devise
  end

  def authenticate_user_with_devise
    user = User.find_for_database_authentication(email: user_params[:email])

    if user && user.valid_for_authentication? { user.valid_password?(user_params[:password]) }
      user.update_attribute(:failed_attempts, 0) unless user.failed_attempts.zero?
      return user
    end

    raise UnauthorizedAccess
  end

  def user_params
    @user_params ||= if @user_params.nil?
      user_parameters = params.require(:user)
      user_parameters.require(:email)
      user_parameters.require(:password)
      user_parameters.permit(:email, :password)
    end
  end
end
