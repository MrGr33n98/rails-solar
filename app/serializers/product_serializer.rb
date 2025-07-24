class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :seo_url, :seo_title, :status, :kind, :premium_until, :source, :country, :name_translations, :description_translations
end