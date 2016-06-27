class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :gender
      t.date :birth_date

      t.timestamps null: false
    end
  end
end
