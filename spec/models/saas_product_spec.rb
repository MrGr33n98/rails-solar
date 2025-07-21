require 'rails_helper'

RSpec.describe SaasProduct, type: :model do
  describe 'associations' do
    it { should have_many(:saas_plans) }
    it { should have_many(:saas_leads) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:billing_cycle) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { should validate_inclusion_of(:billing_cycle).in_array(%w[monthly annually one_time]) }
  end

  describe 'scopes' do
    let!(:active_product) { create(:saas_product, active: true) }
    let!(:inactive_product) { create(:saas_product, active: false) }

    it '.active_products returns only active products' do
      expect(SaasProduct.active_products).to include(active_product)
      expect(SaasProduct.active_products).to_not include(inactive_product)
    end
  end

  describe 'association integration' do
    let!(:saas_product) { create(:saas_product) }
    let!(:saas_plan) { create(:saas_plan, saas_product: saas_product) }
    let!(:saas_lead) { create(:saas_lead, saas_product: saas_product) }

    it 'has associated saas plans' do
      expect(saas_product.saas_plans).to include(saas_plan)
    end

    it 'has associated saas leads' do
      expect(saas_product.saas_leads).to include(saas_lead)
    end
  end
end