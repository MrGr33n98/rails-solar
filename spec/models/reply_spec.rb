require 'rails_helper'

RSpec.describe Reply, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:discussion) }
  end

  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_least(5) }
  end

  # describe 'callbacks' do
  #   it 'notifies discussion author after creation' do
  #     # Implement and test notification logic here
  #   end
  # end
end