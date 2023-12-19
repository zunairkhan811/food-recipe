class CreateFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :foods do |t|
      t.string :name, null: false
      t.string :measurement_unit
      t.integer :price
      t.integer :quantity
    
      t.timestamps
    end
  end
end
