require 'rails_helper'

RSpec.describe PricingRule, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:condition) }
    it { should validate_presence_of(:discount_pct) }

    it { should validate_numericality_of(:discount_pct).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:discount_pct).is_less_than_or_equal_to(100) }

    it 'validates condition format with valid regex' do
      should allow_value('price > 100').for(:condition)
      should allow_value('category == "Electronics"').for(:condition)
      should_not allow_value('invalid; code').for(:condition)
    end
  end
end