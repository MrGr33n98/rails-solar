class AddNotNullToCertificationsFields < ActiveRecord::Migration[7.0]
  def change
    change_column_null :certifications, :name, false
    change_column_null :certifications, :issued_by, false
    change_column_null :certifications, :issued_at, false
    change_column_null :certifications, :expires_at, false
  end
end
