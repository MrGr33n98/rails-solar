class AddSeoFieldsToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :seo_title, :string
    add_column :categories, :seo_description, :text
    add_column :categories, :seo_keywords, :string
    add_column :categories, :canonical_url, :string
    add_column :categories, :meta_robots, :string
    add_column :categories, :h1, :string
    add_column :categories, :intro_text, :text
    add_column :categories, :schema_markup, :text
  end
end
