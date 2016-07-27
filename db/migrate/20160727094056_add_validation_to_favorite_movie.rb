class AddValidationToFavoriteMovie < ActiveRecord::Migration
  def up
    change_column :favorite_movies, :movie_id, :integer, null: false
    change_column :favorite_movies, :user_id, :integer, null: false
  end

  def down
    change_column :favorite_movies, :movie_id, :integer, null: true
    change_column :favorite_movies, :user_id, :integer, null: true
  end
end
