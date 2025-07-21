require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('test@example.com').for(:email) }
    it { should_not allow_value('invalid-email').for(:email) }
    it { should validate_presence_of(:role) }
  end

  describe 'enums' do
    it { should define_enum_for(:role).with_values(admin: 0, super_admin: 1) }
  end

  describe 'associations' do
    # Add associations tests here if AdminUser has any
    # it { should have_many(:some_association) }
  end

  describe 'authentication' do
    # Test Devise authentication methods
    it 'is valid with a valid password' do
      admin_user = create(:admin_user, password: 'password123', password_confirmation: 'password123')
      expect(admin_user.valid_password?('password123')).to be_truthy
    end

    it 'is not valid with an invalid password' do
      admin_user = create(:admin_user, password: 'password123', password_confirmation: 'password123')
      expect(admin_user.valid_password?('wrong_password')).to be_falsey
    end
  end
end