require 'rails_helper'

RSpec.describe SaaSPlan, type: :model do
  describe 'associations' do
    it { should belong_to(:saas_product) }
  end

  describe 'enums' do
    it { should define_enum_for(:tier).with_values(basic: 0, standard: 1, premium: 2) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:tier) }
    it { should validate_numericality_of(:price).is_greater_than(0) }

    it 'validates features as valid JSON' do
      plan = build(:saas_plan, features: '{"key": "value"}')
      expect(plan).to be_valid

      plan = build(:saas_plan, features: 'invalid json')
      plan.valid?
      expect(plan.errors[:features]).to include("must be a valid JSON string")
    end
  end

  describe 'scopes' do
    let!(:basic_plan) { create(:saas_plan, tier: :basic) }
    let!(:premium_plan) { create(:saas_plan, tier: :premium) }

    it '.by_tier returns plans for a specific tier' do
      expect(SaaSPlan.by_tier(:basic)).to include(basic_plan)
      expect(SaaSPlan.by_tier(:basic)).to_not include(premium_plan)
    end
  end
end