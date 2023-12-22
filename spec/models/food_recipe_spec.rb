require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  it 'quantity, food, recipe should be present' do
    user = User.new(name: 'John', email: 'john@email')
    recipe = Recipe.new(name: 'Momo', preparation_time: '30', cooking_time: '30', user:)
    food = Food.new(name: 'Chicken', measurement_unit: 'g', quantity: '200', price: '0.4', user:)
    recipe_food = RecipeFood.new(quantity: '100', food:, recipe:)
    expect(recipe_food).to be_valid
  end

  it 'quantity should be present' do
    user = User.new(name: 'John', email: 'john@email')
    recipe = Recipe.new(name: 'Momo', preparation_time: '30', cooking_time: '30', user:)
    food = Food.new(name: 'Chicken', measurement_unit: 'g', quantity: '200', price: '0.4', user:)
    recipe_food = RecipeFood.new(food:, recipe:)
    expect(recipe_food).to_not be_valid
  end

  it 'quantity should be positive' do
    user = User.new(name: 'John', email: 'john@email')
    recipe = Recipe.new(name: 'Momo', preparation_time: '30', cooking_time: '30', user:)
    food = Food.new(name: 'Chicken', measurement_unit: 'g', quantity: '200', price: '0.4', user:)
    recipe_food = RecipeFood.new(quantity: '-20', food:, recipe:)
    expect(recipe_food).to_not be_valid
  end

  it 'food should be present' do
    user = User.new(name: 'User', email: 'user@email')
    recipe = Recipe.new(name: 'Momo', preparation_time: '30', cooking_time: '30', user:)
    recipe_food = RecipeFood.new(quantity: '20', recipe:)
    expect(recipe_food).to_not be_valid
  end

  it 'recipe should be present' do
    user = User.new(name: 'User', email: 'user@email')
    food = Food.new(name: 'Chicken', measurement_unit: 'g', quantity: '200', price: '0.4', user:)
    recipe_food = RecipeFood.new(quantity: '20', food:)
    expect(recipe_food).to_not be_valid
  end
end
