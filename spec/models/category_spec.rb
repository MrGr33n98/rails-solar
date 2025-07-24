require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { should have_and_belong_to_many(:products) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:slug) }

    context 'slug uniqueness' do
      let!(:root_category) { create(:category, name: 'Root Category', slug: 'root-category') }
      let!(:child_category) { create(:category, name: 'Child Category', parent: root_category, slug: 'child-category') }

      it 'validates uniqueness of slug within the same level' do
        new_child = build(:category, name: 'Another Child', parent: root_category, slug: 'child-category')
        expect(new_child).to_not be_valid
        expect(new_child.errors[:slug]).to include("must be unique within its level")
      end

      it 'allows same slug in different levels' do
        another_root = create(:category, name: 'Another Root', slug: 'another-root')
        new_child = build(:category, name: 'Child Category', parent: another_root, slug: 'child-category')
        expect(new_child).to be_valid
      end
    end
  end

  describe 'callbacks' do
    it 'generates slug before validation on create' do
      category = build(:category, name: 'Test Category Name', slug: nil)
      category.valid?
      expect(category.slug).to eq('test-category-name')
    end

    it 'does not change slug if already present' do
      category = build(:category, name: 'Test Category Name', slug: 'custom-slug')
      category.valid?
      expect(category.slug).to eq('custom-slug')
    end
  end

  
end