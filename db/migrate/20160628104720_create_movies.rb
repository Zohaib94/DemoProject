class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.date :release_date
      t.string :genre
      t.integer :duration
      t.text :description
      t.text :trailer_url
      t.boolean :featured
      t.boolean :approved

      t.timestamps null: false
    end
  end
end
