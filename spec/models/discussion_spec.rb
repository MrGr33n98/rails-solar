require 'rails_helper'

RSpec.describe Discussion, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:product) }
    it { should belong_to(:category) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(open: 0, closed: 1, archived: 2) }
  end

  describe 'validations' do
    it { should validate_presence_of(:subject) }
    it { should validate_length_of(:subject).is_at_least(5) }
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_least(10) }
    it { should validate_presence_of(:status) }
  end

  describe 'scopes' do
    let!(:old_discussion) { create(:discussion, created_at: 2.days.ago) }
    let!(:recent_discussion) { create(:discussion, created_at: 1.hour.ago) }

    it '.recent returns discussions ordered by creation date and limited to 10' do
      # Create more than 10 discussions to test the limit
      15.times { create(:discussion) }
      expect(Discussion.recent.count).to eq(10)
      expect(Discussion.recent.first).to be_within(1.minute).of(Discussion.order(created_at: :desc).first)
    end
  end
end