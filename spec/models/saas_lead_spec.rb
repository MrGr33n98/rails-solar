require 'rails_helper'

RSpec.describe SaasLead, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:saas_product) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(new_lead: 0, contacted: 1, qualified: 2, unqualified: 3, converted: 4) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should allow_value('test@example.com').for(:email) }
    it { should_not allow_value('invalid-email').for(:email) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:status) }

    context 'contacted_at presence based on status' do
      it 'requires contacted_at if status is contacted' do
        lead = build(:saas_lead, status: :contacted, contacted_at: nil)
        lead.valid?
        expect(lead.errors[:contacted_at]).to include("can't be blank")
      end

      it 'does not require contacted_at if status is new_lead' do
        lead = build(:saas_lead, status: :new_lead, contacted_at: nil)
        expect(lead).to be_valid
      end
    end
  end

  describe 'scopes' do
    let!(:recent_lead) { create(:saas_lead, created_at: 1.hour.ago) }
    let!(:old_lead) { create(:saas_lead, created_at: 2.days.ago) }

    it '.recent_leads returns leads ordered by creation date and limited to 10' do
      # Create more than 10 leads to test the limit
      15.times { create(:saas_lead) }
      expect(SaasLead.recent_leads.count).to eq(10)
      expect(SaasLead.recent_leads.first).to be_within(1.minute).of(SaasLead.order(created_at: :desc).first)
    end
  end
end