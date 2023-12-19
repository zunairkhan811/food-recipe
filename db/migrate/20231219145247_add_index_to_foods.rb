class AddIndexToFoods < ActiveRecord::Migration[7.1]
  def change
    add_reference :foods, :user, foreign_key: true
  end
end
