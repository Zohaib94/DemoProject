class AddValidationToReportedReview < ActiveRecord::Migration
  def up
    change_column :reported_reviews, :review_id, :integer, null: false
    change_column :reported_reviews, :user_id, :integer, null: false
  end

  def down
    change_column :reported_reviews, :review_id, :integer, null: true
    change_column :reported_reviews, :user_id, :integer, null: true
  end
end
