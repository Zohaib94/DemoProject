class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :first_name, limit: 30
      t.string :last_name, limit: 30
      t.date :birth_date
      t.text :biography
      t.string :gender, limit: 10
      t.string :country, limit: 20
      t.string :city, limit: 20

      t.timestamps null: false
    end
  end
end
