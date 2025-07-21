require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:certifications).dependent(:destroy) }
    it { should have_many(:reviews).dependent(:destroy) }
    it { should have_many(:quotes).dependent(:destroy) }
  end

  describe 'enums' do
    it { should define_enum_for(:target_segment).with_values(residential: 0, commercial: 1, industrial: 2, public_sector: 3) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:target_segment) }
  end

  # describe 'geocoding' do
  #   # Add tests for geocoding if a concern is implemented
  # end
end