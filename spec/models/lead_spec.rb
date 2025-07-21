require 'rails_helper'

RSpec.describe Lead, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:product) }
  end

  describe 'enums' do
    it { should define_enum_for(:conversion_state).with_values(new_lead: 0, contacted: 1, qualified: 2, unqualified: 3, converted: 4) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should allow_value('test@example.com').for(:email) }
    it { should_not allow_value('invalid-email').for(:email) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:conversion_state) }
  end

  describe 'scopes' do
    let!(:qualified_lead) { create(:lead, conversion_state: :qualified) }
    let!(:new_lead) { create(:lead, conversion_state: :new_lead) }

    it '.qualified returns only qualified leads' do
      expect(Lead.qualified).to include(qualified_lead)
      expect(Lead.qualified).to_not include(new_lead)
    end
  end

  # describe 'lead assignment flows' do
  #   # Add tests for lead assignment logic here
  # end
end