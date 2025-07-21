class CompanySerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :description,
             :verified,
             :target_segment,
             :annual_energy_output,
             :installation_count,
             :user_id,
             :created_at,
             :updated_at

  belongs_to :user
  has_many   :certifications
  has_many   :reviews
end