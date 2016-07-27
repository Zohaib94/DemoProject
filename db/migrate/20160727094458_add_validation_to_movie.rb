class AddValidationToMovie < ActiveRecord::Migration
  def up
    change_column :movies, :release_date, :date, null: false
    change_column :movies, :trailer_url, :text, null: false, limit: 1000
    change_column :movies, :title, :string, null: false
    change_column :movies, :description, :text, null: false, limit: 255
  end

  def down
    change_column :movies, :release_date, :date, null: true
    change_column :movies, :trailer_url, :text, null: true, limit: 65535
    change_column :movies, :title, :string, null: true
    change_column :movies, :description, :text, null: true, limit: 65535
  end
end
