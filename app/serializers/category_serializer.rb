class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :description, :parent_id, :active, :seo_title, :seo_description, :seo_keywords, :canonical_url, :meta_robots, :h1, :intro_text, :schema_markup, :name_translations, :description_translations
end