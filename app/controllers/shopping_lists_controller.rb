class ShoppingListsController < ApplicationController
  def index
    @recipe_foods_quantity = current_user.recipe_foods.group(:food_id).sum(:quantity)
    @foods = current_user.foods

    @total_items = 0
    @total_value = 0

    @foods.each do |food|
      food_quantity = @recipe_foods_quantity[food.id] - food.quantity
      if food_quantity.positive?
        @total_items += food_quantity
        @total_value += food_quantity * food.price
      end
    end
  end
end
