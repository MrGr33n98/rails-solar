require 'rails_helper'

RSpec.describe MarketingCampaign, type: :model do
  describe 'enums' do
    it { should define_enum_for(:channel).with_values(email: 0, sms: 1, push: 2) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:channel) }
    it { should validate_presence_of(:template) }
    it { should validate_presence_of(:scheduled_at) }

    it 'validates that scheduled_at is in the future' do
      campaign = build(:marketing_campaign, scheduled_at: 1.day.ago)
      campaign.valid?
      expect(campaign.errors[:scheduled_at]).to include("must be in the future")
    end

    it 'is valid when scheduled_at is in the future' do
      campaign = build(:marketing_campaign, scheduled_at: 1.day.from_now)
      expect(campaign).to be_valid
    end
  end

  describe 'scopes' do
    let!(:upcoming_campaign) { create(:marketing_campaign, scheduled_at: 1.day.from_now) }
    let!(:past_campaign) { create(:marketing_campaign, scheduled_at: 1.day.ago) }

    it '.upcoming returns campaigns scheduled in the future' do
      expect(MarketingCampaign.upcoming).to include(upcoming_campaign)
      expect(MarketingCampaign.upcoming).to_not include(past_campaign)
    end

    it '.past returns campaigns scheduled in the past' do
      expect(MarketingCampaign.past).to include(past_campaign)
      expect(MarketingCampaign.past).to_not include(upcoming_campaign)
    end
  end
end