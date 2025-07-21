class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_rich_text :body

  enum status: { pending: 0, approved: 1, rejected: 2 }

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications
  before_create :set_default_status

  has_noticed_notifications model_name: 'Noticed::Event'
  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: 'Noticed::Event'

  validates :body, presence: true, length: { minimum: 5 }
  validate :no_curse_words

  def self.ransackable_attributes(_auth_object = nil)
    %w[user_id post_id status created_at updated_at] # Allow searching by user_id, post_id, and status
  end

  def self.ransackable_associations(_auth_object = nil)
    ["user", "post"] # Allow searching by user and post associations
  end

  private

  def notify_recipient
    CommentNotifier.with(record: self, post:).deliver_later(post.user)
  end

  def cleanup_notifications
    post.notifications.where(id: post.id).destroy_all
  end

  def no_curse_words
    plain_text_body = body.to_plain_text if body.present?
    return unless plain_text_body.present? && curse_word_found?(plain_text_body)

    errors.add(:base, 'Your comment contains inappropriate language and cannot be saved.')
  end

  def curse_word_found?(text)
    CURSE_WORDS.any? { |word| text.match?(Regexp.new(word, Regexp::IGNORECASE)) }
  end

  def set_default_status
    self.status ||= :pending
  end
end
