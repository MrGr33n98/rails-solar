class AddNotNullAndDefaultToRepliesFields < ActiveRecord::Migration[7.0]
  def change
    change_column_null :replies, :body, false
    change_column_null :replies, :status, false
    change_column_default :replies, :status, 0
  end
end
