class AddSeoFieldsToContents < ActiveRecord::Migration[7.0]
  def change
    add_column :contents, :seo_title, :string
    add_column :contents, :seo_description, :text
    add_column :contents, :seo_keywords, :string
    add_column :contents, :canonical_url, :string
    add_column :contents, :meta_robots, :string
    add_column :contents, :h1, :string
    add_column :contents, :intro_text, :text
    add_column :contents, :schema_markup, :text
  end
end
