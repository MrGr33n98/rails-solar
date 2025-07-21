require 'rails_helper'

RSpec.describe FeatureGroup, type: :model do
  describe 'associations' do
    it { should have_many(:features).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'dependent destroy' do
    let!(:feature_group) { create(:feature_group) }
    let!(:feature) { create(:feature, feature_group: feature_group) }

    it 'destroys associated features when destroyed' do
      expect { feature_group.destroy }.to change(Feature, :count).by(-1)
    end
  end
end