class Cats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.date :birth_date
      t.string :color, null: false
      t.string :name, null: false
      t.string :sex
      t.text :description
    end
  end
end
