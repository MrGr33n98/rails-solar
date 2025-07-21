require 'rails_helper'

RSpec.describe AssessCampaign, type: :model do
  describe 'associations' do
    it { should belong_to(:product) }
    it { should belong_to(:owner).class_name('User') }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(draft: 0, active: 1, completed: 2, cancelled: 3) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:goal) }
    it { should validate_presence_of(:starts_at) }
    it { should validate_presence_of(:ends_at) }
    it { should validate_presence_of(:status) }
    it { should validate_numericality_of(:goal).is_greater_than(0) }

    it 'validates that ends_at is after starts_at' do
      campaign = build(:assess_campaign, starts_at: Time.current, ends_at: 1.day.ago)
      campaign.valid?
      expect(campaign.errors[:ends_at]).to include("cannot be before starts_at")
    end

    it 'is valid when ends_at is after starts_at' do
      campaign = build(:assess_campaign, starts_at: 1.day.ago, ends_at: Time.current)
      expect(campaign).to be_valid
    end
  end

  describe 'scopes' do
    let!(:ongoing_campaign) { create(:assess_campaign, starts_at: 1.day.ago, ends_at: 1.day.from_now) }
    let!(:completed_campaign) { create(:assess_campaign, starts_at: 2.days.ago, ends_at: 1.day.ago) }

    it '.ongoing returns campaigns that are currently active' do
      expect(AssessCampaign.ongoing).to include(ongoing_campaign)
      expect(AssessCampaign.ongoing).to_not include(completed_campaign)
    end

    it '.completed returns campaigns that have ended' do
      expect(AssessCampaign.completed).to include(completed_campaign)
      expect(AssessCampaign.completed).to_not include(ongoing_campaign)
    end
  end
end