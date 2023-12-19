class RecipeFood < ApplicationRecord
  belongs_to :recipe, foreign_key: :cooking_time
  belongs_to :food, foreign_key: :measurement_unit

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
