class AddNotNullAndDefaultToReviewsFields < ActiveRecord::Migration[7.0]
  def change
    change_column_null :reviews, :rating, false
    change_column_null :reviews, :title, false
    change_column_null :reviews, :content, false
    change_column_null :reviews, :status, false
    change_column_default :reviews, :status, 0
  end
end
