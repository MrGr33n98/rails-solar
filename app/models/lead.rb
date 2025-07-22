class Lead < ApplicationRecord
  belongs_to :user
  belongs_to :product

  enum conversion_state: {
    new_lead:    0,
    contacted:   1,
    qualified:   2,
    unqualified: 3,
    converted:   4
  }

  validates :name, :email, :role, :conversion_state, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :qualified, -> { where(conversion_state: :qualified) }

  # Exemplo de método de conversão
  def convert!
    transaction do
      # Exemplo: criar um registro relacionado ao converter o lead
      # Ajuste conforme sua lógica de negócio
      update!(conversion_state: :converted, sent_at: Time.current)
    end
  end

  def full_name
    name
  end

  # Permite buscas por essas associações no ActiveAdmin/Ransack
  def self.ransackable_associations(_auth_object = nil)
    %w[user product]
  end

  # Permite buscas por esses atributos no ActiveAdmin/Ransack
  def self.ransackable_attributes(_auth_object = nil)
    super + %w[
      id user_id product_id name email role company_size desired_category
      funnel_stage score sent_at created_at updated_at conversion_state
    ]
  end
end