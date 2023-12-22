class ShoppingListsController < ApplicationController
  def index
    @recipe_foods_quantity = current_user.recipe_foods.group(:food_id).sum(:quantity)
    @foods = current_user.foods
    @items_to_buy = []

    @total_items = 0
    @total_value = 0

    @foods.each do |food|
      next unless @recipe_foods_quantity[food.id].present? && @recipe_foods_quantity[food.id] > food.quantity

      food_quantity = @recipe_foods_quantity[food.id] - food.quantity
      food_item = { name: food.name, quantity: food_quantity, value: food_quantity * food.price }
      @items_to_buy << food_item
      if food_quantity.positive?
        @total_items += food_quantity
        @total_value += food_quantity * food.price
      end
    end
  end
end
