require 'rails_helper'

describe AccessToken do

  context '.create!' do
    it 'generates locator and secret' do
      access_token = AccessToken.create!
      expect(access_token.locator).to match /\A[a-zA-Z0-9_-]{64}\z/
      expect(access_token.secret).to match /\A[a-zA-Z0-9_-]{256}\z/
    end
  end

  context '#unencrypted' do
    it 'returns plain token in format "locator:secret"' do
      access_token = AccessToken.create!
      expect(access_token.unencrypted).to eq "#{access_token.locator}:#{access_token.secret}"
    end
  end

  context 'associations' do
    it { should belong_to(:user) }
  end

  context 'attributes' do

    context 'locator' do

      it { should have_db_column(:locator).of_type(:string).with_options(null: false) }
      it { should have_db_index(:locator).unique }

      context 'validation' do
        subject { AccessToken.new(secret: 'this-is-a-test-secret') }
        it { should validate_uniqueness_of(:locator) }
        it { should validate_length_of(:locator).is_equal_to(64) }
      end

      it 'generates long random value before validation' do
        access_token = AccessToken.new
        expect(access_token.locator).to be_nil
        access_token.validate
        expect(access_token.locator).to match /\A[a-zA-Z0-9_-]{64}\z/
      end

      it 'generates with secure random number generator' do
        access_token = AccessToken.new(secret: 'some-secret')
        default_length_in_bytes = 48

        expect(access_token.locator).to be_nil
        expect(SecureRandom).to receive(:urlsafe_base64).with(default_length_in_bytes).and_return('locator-for-testing')
        access_token.validate
        expect(access_token.locator).to eq 'locator-for-testing'
      end

      it 'does not overwrite existing value' do
        access_token = AccessToken.new(locator: 'pre-existing-locator')
        access_token.validate
        expect(access_token.locator).to eq 'pre-existing-locator'
      end
    end

    context 'secret' do
      it 'has column name for encryption' do
          should have_db_column(:encrypted_secret).of_type(:text).with_options(null: false)
      end
      it 'has no plain column name' do
        should_not have_db_column(:secret)
      end

      context 'validation' do
        it { should validate_length_of(:secret).is_equal_to(256) }
      end

      context 'encryption' do
        it 'is an encrypted attribute' do
          expect(AccessToken.encrypted_attributes).to eq({ secret: :encrypted_secret })
        end

        it 'occurs upon initialization' do
          access_token = AccessToken.new(secret: 'what-a-lovely-secret')
          expect(access_token.encrypted_secret).to be_present
          expect(SymmetricEncryption.decrypt(access_token.encrypted_secret)).to eq 'what-a-lovely-secret'
        end

        it 'occurs upon assignment' do
          access_token = AccessToken.new
          access_token.secret = 'hello-world-secret'
          expect(access_token.encrypted_secret).to be_present
          expect(SymmetricEncryption.decrypt(access_token.encrypted_secret)).to eq 'hello-world-secret'
        end

        it 'provides unencrypted value when taken from db' do
          secret = 'x'*256
          AccessToken.create!(secret: secret)
          access_token = AccessToken.last
          expect(access_token.secret).to eq 'x'*256
        end

        it 'does not store unencrypted value in encrypted_secret string' do
          secret = 'x'*256
          access_token = AccessToken.new(secret: secret)
          expect(access_token.encrypted_secret).not_to include secret
          access_token.save!
          access_token = AccessToken.last
          expect(access_token.encrypted_secret).not_to include secret
        end

        it 'uses random iv so encrypted_secret differs for same unencrypted secret' do
          access_token = AccessToken.new
          access_token.secret = 'enjoy-this-test-secret'
          first_encrypted_value = access_token.encrypted_secret

          # Reassigning secret (even to same value) triggers fresh encryption
          access_token.secret = 'enjoy-this-test-secret'
          second_encrypted_value = access_token.encrypted_secret

          expect(first_encrypted_value).not_to be_blank
          expect(second_encrypted_value).not_to be_blank
          expect(first_encrypted_value).not_to eq second_encrypted_value
        end
      end

      it 'generates long random value before validation' do
        access_token = AccessToken.new
        expect(access_token.secret).to be_nil
        access_token.validate
        expect(access_token.secret).to match /\A[a-zA-Z0-9_-]{256}\z/
      end

      it 'generates with secure random number generator' do
        access_token = AccessToken.new(locator: 'some-locator')
        default_length_in_bytes = 192

        expect(access_token.secret).to be_nil
        expect(SecureRandom).to receive(:urlsafe_base64).with(default_length_in_bytes).and_return('secret-for-testing')
        access_token.validate
        expect(access_token.secret).to eq 'secret-for-testing'
      end

      it 'does not overwrite existing value' do
        access_token = AccessToken.new(secret: 'pre-existing-secret')
        access_token.validate
        expect(access_token.secret).to eq 'pre-existing-secret'
      end

    end
  end

end
