require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { should have_and_belong_to_many(:categories) }
    it { should have_many(:feature_groups).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:kind) }

    it { should validate_uniqueness_of(:seo_url).allow_blank }
      it { should validate_presence_of(:seo_title).allow_blank }
      it { should validate_length_of(:seo_title).is_at_most(60).allow_blank }
  end

  describe 'callbacks' do
    it 'generates seo_url before validation on create' do
      product = build(:product, name: 'Test Product Name', seo_url: nil)
      product.valid?
      expect(product.seo_url).to eq('test-product-name')
    end

    it 'does not change seo_url if already present' do
      product = build(:product, name: 'Test Product Name', seo_url: 'custom-seo-url')
      product.valid?
      expect(product.seo_url).to eq('custom-seo-url')
    end
  end
end