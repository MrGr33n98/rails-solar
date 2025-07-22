module ProfanityFilter
  extend ActiveSupport::Concern

  CURSE_WORDS = %w[badword1 badword2].freeze # Define your list of curse words here

  included do
    validate :no_curse_words
  end

  private

  def no_curse_words
    text_to_check = ""
    if self.respond_to?(:body) && body.present?
      text_to_check += body.to_s
    end
    if self.respond_to?(:title) && title.present?
      text_to_check += " " + title.to_s
    end

    if curse_word_found?(text_to_check)
      errors.add(:base, 'Contains inappropriate language')
    end
  end

  def curse_word_found?(text)
    CURSE_WORDS.any? { |word| text.match?(Regexp.new("\\b#{Regexp.escape(word)}\\b", Regexp::IGNORECASE)) }
  end
end