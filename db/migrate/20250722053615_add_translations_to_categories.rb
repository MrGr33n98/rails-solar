class AddTranslationsToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :name_translations, :text # Stores JSON
    add_column :categories, :description_translations, :text # Stores JSON
  end
end
