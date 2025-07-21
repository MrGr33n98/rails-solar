require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(5).is_at_most(50) }
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_least(10).is_at_most(1000) }

    it 'validates against curse words in title' do
      stub_const('CURSE_WORDS', ['badword'])
      post = build(:post, title: 'This is a badword title')
      post.valid?
      expect(post.errors[:title]).to include('contains inappropriate language')
    end

    it 'validates against curse words in body' do
      stub_const('CURSE_WORDS', ['badword'])
      post = build(:post, body: 'This is a badword body')
      post.valid?
      expect(post.errors[:body]).to include('contains inappropriate language')
    end
  end

  describe 'scopes' do
    let!(:published_post) { create(:post, published_at: Time.current) }
    let!(:draft_post) { create(:post, published_at: nil) }

    it '.published returns only published posts' do
      expect(Post.published).to include(published_post)
      expect(Post.published).to_not include(draft_post)
    end

    it '.draft returns only draft posts' do
      expect(Post.draft).to include(draft_post)
      expect(Post.draft).to_not include(published_post)
    end
  end

  # describe 'auto-publishing tests' do
  #   # Add tests for auto-publishing logic here if applicable
  # end
end