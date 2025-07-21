require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(pending: 0, approved: 1, rejected: 2) }
  end

  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_least(5) }

    it 'validates against curse words' do
      # Assuming CURSE_WORDS is defined globally or in an initializer
      stub_const('CURSE_WORDS', ['badword'])
      comment = build(:comment, body: 'This is a badword comment')
      comment.valid?
      expect(comment.errors[:base]).to include('Your comment contains inappropriate language and cannot be saved.')
    end

    it 'is valid without curse words' do
      stub_const('CURSE_WORDS', ['badword'])
      comment = build(:comment, body: 'This is a good comment')
      expect(comment).to be_valid
    end
  end

  describe 'callbacks' do
    it 'sets default status to pending before creation' do
      comment = create(:comment, status: nil)
      expect(comment.status).to eq('pending')
    end

    it 'notifies recipient after creation' do
      ActiveJob::Base.queue_adapter = :test
      expect { create(:comment) }.to have_enqueued_job(ActionMailer::MailDeliveryJob)
    end
  end
end