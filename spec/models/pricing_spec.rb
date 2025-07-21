require 'rails_helper'

RSpec.describe Pricing, type: :model do
  describe 'associations' do
    it { should belong_to(:product) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:currency) }
    it { should validate_presence_of(:value) }
    it { should validate_presence_of(:charge_type) }
    it { should validate_presence_of(:frequency) }
    it { should validate_numericality_of(:value).is_greater_than(0) }
  end

  describe 'scopes' do
    let!(:active_pricing) { create(:pricing, state: :active) }
    let!(:inactive_pricing) { create(:pricing, state: :inactive) }
    let!(:usd_pricing) { create(:pricing, currency: 'USD') }
    let!(:eur_pricing) { create(:pricing, currency: 'EUR') }

    it '.active returns only active pricings' do
      expect(Pricing.active).to include(active_pricing)
      expect(Pricing.active).to_not include(inactive_pricing)
    end

    it '.by_currency returns pricings for a specific currency' do
      expect(Pricing.by_currency('USD')).to include(usd_pricing)
      expect(Pricing.by_currency('USD')).to_not include(eur_pricing)
    end
  end
end