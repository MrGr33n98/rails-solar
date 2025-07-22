class RemoveAncestryFromCategories < ActiveRecord::Migration[7.0]
  def up
    # Temporarily disable foreign key checks for SQLite
    execute 'PRAGMA foreign_keys = OFF;'

    # Rename the original table
    rename_table :categories, :categories_old

    # Create the new table without the 'ancestry' and 'depth' columns
    create_table :categories do |t|
      t.string   "name"
      t.string   "slug"
      t.text     "description"
      t.integer  "parent_id"
      t.boolean  "active"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string   "seo_title"
      t.text     "seo_description"
      t.string   "seo_keywords"
      t.string   "canonical_url"
      t.string   "meta_robots"
      t.string   "h1"
      t.text     "intro_text"
      t.text     "schema_markup"
      t.index ["parent_id"], name: "index_categories_on_parent_id"
    end

    # Copy data from the old table to the new one
    # Note: We need to explicitly list all columns to ensure correct mapping
    execute <<-SQL
      INSERT INTO categories (id, name, slug, description, parent_id, active, created_at, updated_at, seo_title, seo_description, seo_keywords, canonical_url, meta_robots, h1, intro_text, schema_markup)
      SELECT id, name, slug, description, parent_id, active, created_at, updated_at, seo_title, seo_description, seo_keywords, canonical_url, meta_robots, h1, intro_text, schema_markup FROM categories_old;
    SQL

    # Drop the old table
    drop_table :categories_old

    # Re-enable foreign key checks
    execute 'PRAGMA foreign_keys = ON;'
  end

  def down
    # This migration is not easily reversible
    raise ActiveRecord::IrreversibleMigration
  end
end
