class AddRatingAndCommentToReviews < ActiveRecord::Migration[7.1]
  def change
    add_column :reviews, :rating, :integer, null: false
    add_column :reviews, :comment, :text, limit: 500
  end
end
