class AddNotNullAndDefaultToQuotesFields < ActiveRecord::Migration[7.0]
  def change
    change_column_null :quotes, :name, false
    change_column_null :quotes, :email, false
    change_column_null :quotes, :phone, false
    change_column_null :quotes, :message, false
    change_column_null :quotes, :status, false
    change_column_default :quotes, :status, 0
  end
end
