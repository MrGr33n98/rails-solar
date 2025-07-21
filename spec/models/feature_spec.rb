require 'rails_helper'

RSpec.describe Feature, type: :model do
  describe 'associations' do
    it { should belong_to(:feature_group) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    context 'uniqueness scoped to feature_group_id' do
      let!(:feature_group) { create(:feature_group) }
      let!(:existing_feature) { create(:feature, name: 'Existing Feature', feature_group: feature_group) }

      it 'validates uniqueness of name within the same feature group' do
        new_feature = build(:feature, name: 'Existing Feature', feature_group: feature_group)
        expect(new_feature).to_not be_valid
        expect(new_feature.errors[:name]).to include("has already been taken")
      end

      it 'allows same name in different feature groups' do
        another_feature_group = create(:feature_group)
        new_feature = build(:feature, name: 'Existing Feature', feature_group: another_feature_group)
        expect(new_feature).to be_valid
      end
    end
  end
end