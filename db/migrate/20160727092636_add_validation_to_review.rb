class AddValidationToReview < ActiveRecord::Migration
  def up
    change_column :reviews, :comment, :text, null: false, limit: 50
    change_column :reviews, :movie_id, :integer, null: false
    change_column :reviews, :user_id, :integer, null: false
  end

  def down
    change_column :reviews, :comment, :text, null: true, limit: 65535
    change_column :reviews, :movie_id, :integer, null: true
    change_column :reviews, :user_id, :integer, null: true
  end
end
