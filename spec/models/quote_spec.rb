require 'rails_helper'

RSpec.describe Quote, type: :model do
  describe 'associations' do
    it { should belong_to(:company) }
    it { should belong_to(:user).optional(true) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(pending: 0, responded: 1, closed: 2) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:message) }
  end

  describe 'scopes' do
    let!(:pending_quote) { create(:quote, status: :pending) }
    let!(:responded_quote) { create(:quote, status: :responded) }

    it '.pending returns only pending quotes' do
      expect(Quote.pending).to include(pending_quote)
      expect(Quote.pending).to_not include(responded_quote)
    end
  end

  describe 'create' do
    it 'creates a valid quote' do
      quote = build(:quote)
      expect(quote).to be_valid
      expect { quote.save }.to change(Quote, :count).by(1)
    end
  end
end