require 'rails_helper'

RSpec.describe 'Shopping List Page', type: :system do
  let(:user1) do
    user = User.create(name: 'John Doe', email: 'ali@gmail.com', password: 'password', password_confirmation: 'password')
    user.send_confirmation_instructions
    user.confirm
    user
  end

  let(:food1) { Food.create(name: 'Apple', quantity: 10, measurement_unit: 'pieces', price: 1, user_id: user1.id) }
  let(:food2) { Food.create(name: 'Orange', quantity: 5, measurement_unit: 'pieces', price: 2, user_id: user1.id) }

  let(:recipe1) do
    Recipe.create(name: 'Fruit Salad', preparation_time: 5, cooking_time: 0, description: 'A refreshing fruit salad.', user_id: user1.id)
  end

  let!(:recipe_food1) { RecipeFood.create(recipe_id: recipe1.id, food_id: food1.id, quantity: 15) }
  let!(:recipe_food2) { RecipeFood.create(recipe_id: recipe1.id, food_id: food2.id, quantity: 11) }

  before do
    login_as(user1, scope: :user)
    visit shopping_lists_path
  end

  it 'displays the shopping list details' do
    expect(page).to have_content('Shopping List')
    expect(page).to have_content('Amount of food items to buy:')
    expect(page).to have_content('Total value of food needed:')
    expect(page).to have_content('Food')
    expect(page).to have_content('Quantity')
    expect(page).to have_content('Price')
  end

  it 'displays the food items to buy in the table' do
    within('table') do
      expect(page).to have_content('Food')
      expect(page).to have_content('Quantity')
      expect(page).to have_content('Price')
      expect(page).to have_content('Apple')
      expect(page).to have_content('5')
      expect(page).to have_content('5')
      expect(page).to have_content('Orange')
      expect(page).to have_content('12')
      expect(page).to have_content('6')
    end
  end
end
