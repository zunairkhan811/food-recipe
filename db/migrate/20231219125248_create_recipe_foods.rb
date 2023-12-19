class CreateRecipeFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_foods do |t|
      t.integer :quantity
      t.references :recipe, foreign_key: { to_table: :cooking_times }
      t.references :food, foreign_key: { to_table: :measurement_units }

      t.timestamps
    end
  end
end
