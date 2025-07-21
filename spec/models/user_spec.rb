require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Devise modules' do
    it { should have_db_column(:email).of_type(:string).with_options(null: false, default: '') }
    it { should have_db_column(:encrypted_password).of_type(:string).with_options(null: false, default: '') }
    it { should have_db_column(:reset_password_token).of_type(:string) }
    it { should have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { should have_db_column(:remember_created_at).of_type(:datetime) }
  end

  describe 'enums' do
    it { should define_enum_for(:role).with_values(regular: 0, admin: 1, super_admin: 2) }
  end

  describe 'associations' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:reviews).dependent(:destroy) }
    it { should have_many(:quotes).dependent(:destroy) }
    it { should have_many(:leads).dependent(:destroy) }
    it { should have_many(:saas_leads).dependent(:destroy) }
    it { should have_many(:notifications).dependent(:destroy) }
    it { should have_many(:notification_mentions).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:role) }
  end

  describe 'authentication' do
    it 'is valid with a valid password' do
      user = create(:user, password: 'password123', password_confirmation: 'password123')
      expect(user.valid_password?('password123')).to be_truthy
    end

    it 'is not valid with an invalid password' do
      user = create(:user, password: 'password123', password_confirmation: 'password123')
      expect(user.valid_password?('wrong_password')).to be_falsey
    end
  end

  # describe 'onboarding' do
  #   # Add tests for onboarding flows here
  # end
end