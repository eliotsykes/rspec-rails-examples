module HardenedToken
  extend ActiveSupport::Concern

  LOCATOR_LENGTH = { bytes: 48.freeze, chars: 64.freeze }.freeze
  SECRET_LENGTH = { bytes: 192.freeze, chars: 256.freeze }.freeze

  def unencrypted
    "#{locator}:#{secret}"
  end

  class_methods do

    def hardened_token
      attr_encrypted :secret, random_iv: true

      before_validation do
        self.locator = self.class.generate_locator if locator.blank?
        self.secret = self.class.generate_secret if secret.blank?
      end

      validates_length_of :locator, is: LOCATOR_LENGTH[:chars]
      validates_uniqueness_of :locator, case_sensitive: true

      validates_length_of :secret, is: SECRET_LENGTH[:chars]
      validates :encrypted_secret, symmetric_encryption: true
    end

    def generate_locator
      SecureRandom.urlsafe_base64 LOCATOR_LENGTH[:bytes]
    end

    def generate_secret
      SecureRandom.urlsafe_base64 SECRET_LENGTH[:bytes]
    end
  end

end
