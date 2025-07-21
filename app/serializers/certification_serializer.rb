class CertificationSerializer < ActiveModel::Serializer
  attributes :id,
             :company_id,
             :name,
             :issued_by,
             :issued_at,
             :expires_at,
             :created_at,
             :updated_at

  belongs_to :company
end