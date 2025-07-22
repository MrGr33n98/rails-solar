class AddTranslationsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :name_translations, :text # Stores JSON
    add_column :products, :description_translations, :text # Stores JSON
  end
end
