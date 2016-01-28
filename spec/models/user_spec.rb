require 'rails_helper'

describe User do

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_confirmation_of :password }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_inclusion_of(:role).in_array(["standard", "premium"]) }
  end

  describe 'associations' do
    it { should have_many(:access_tokens).dependent(:destroy) }
  end

  describe '#issue_access_token' do
    it 'creates access token belonging to user' do
      user = create(:user)

      expect do
        access_token = user.issue_access_token
        expect(access_token).to be_persisted
        expect(access_token.user).to eq user
        expect(user.access_tokens).to eq [access_token]
      end.to change { AccessToken.count }.by(1)
    end
  end

  describe '#role' do
    it 'defaults to standard' do
      expect(User.new.role).to eq "standard"
    end
  end
  
  describe '#upgradeable?' do
    it 'returns true for standard user' do
      standard_user = User.new(role: 'standard')
      expect(standard_user.upgradeable?).to eq true
    end
    
    it 'returns false for premium user' do
      premium_user = User.new(role: 'premium')
      expect(premium_user.upgradeable?).to eq false
    end
  end
  
  describe '#standard?' do
    it 'returns true for standard user' do
      standard_user = User.new(role: 'standard')
      expect(standard_user.standard?).to eq true
    end
    
    it 'returns false for premium user' do
      premium_user = User.new(role: 'premium')
      expect(premium_user.standard?).to eq false
    end
  end
  
  describe '#upgrade' do
    it 'upgrades standard user to premium' do
      user = create(:user, role: 'standard')
      user.upgrade
      expect(user.reload.role).to eq 'premium'
    end
    
    it 'does not change premium user role' do
      user = create(:user, role: 'premium')
      user.upgrade
      expect(user.reload.role).to eq 'premium'
    end
  end
end
