require 'rails_helper'

RSpec.describe Content, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:short_description) }
    it { should validate_presence_of(:format) }
    it { should validate_presence_of(:level) }

    it { should validate_inclusion_of(:format).in_array(%w[article video infographic podcast]) }
    it { should validate_inclusion_of(:level).in_array(%w[beginner intermediate advanced]) }
  end

  describe 'scopes' do
    let!(:published_content) { create(:content, active: true) }
    let!(:unpublished_content) { create(:content, active: false) }

    it '.published returns only active content' do
      expect(Content.published).to include(published_content)
      expect(Content.published).to_not include(unpublished_content)
    end
  end

  # describe 'versioning' do
  #   # Add tests for versioning if a concern is implemented
  # end
end