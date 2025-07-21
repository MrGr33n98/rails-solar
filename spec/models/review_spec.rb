require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:company) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(pending: 0, approved: 1, rejected: 2) }
  end

  describe 'validations' do
    it { should validate_inclusion_of(:rating).in_array(1..5) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end

  describe 'scopes' do
    let!(:top_rated_review) { create(:review, rating: 5) }
    let!(:low_rated_review) { create(:review, rating: 2) }

    it '.top_rated returns reviews with rating 4 or 5' do
      expect(Review.top_rated).to include(top_rated_review)
      expect(Review.top_rated).to_not include(low_rated_review)
    end
  end

  # describe 'callbacks' do
  #   it 'notifies company about new review after creation' do
  #     # Implement and test notification logic here
  #   end
  # end
end