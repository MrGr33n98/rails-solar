require 'rails_helper'

RSpec.describe Certification, type: :model do
  describe 'associations' do
    it { should belong_to(:company) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:issued_by) }
    it { should validate_presence_of(:issued_at) }
    it { should validate_presence_of(:expires_at) }

    it 'validates that issued_at is before expires_at' do
      certification = build(:certification, issued_at: Time.current, expires_at: 1.day.ago)
      certification.valid?
      expect(certification.errors[:issued_at]).to include("must be before expires_at")
    end

    it 'is valid when issued_at is before expires_at' do
      certification = build(:certification, issued_at: 1.day.ago, expires_at: Time.current)
      expect(certification).to be_valid
    end
  end
end