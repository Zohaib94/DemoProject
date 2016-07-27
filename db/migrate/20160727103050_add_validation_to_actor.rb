class AddValidationToActor < ActiveRecord::Migration
  def up
    change_column :actors, :first_name, :string, null: false
    change_column :actors, :last_name, :string, null: false
    change_column :actors, :gender, :string, null: false
    change_column :actors, :birth_date, :date, null: false
  end

  def down
    change_column :actors, :first_name, :string, null: true
    change_column :actors, :last_name, :string, null: true
    change_column :actors, :gender, :string, null: true
    change_column :actors, :birth_date, :date, null: true
  end
end
