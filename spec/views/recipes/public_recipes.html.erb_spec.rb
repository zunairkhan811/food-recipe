require 'rails_helper'

RSpec.describe 'Public Recipes Index Page', type: :system do
  let(:user1) do
    user = User.create(name: 'John Doe', email: 'ali@gmail.com', password: 'password', password_confirmation: 'password')
    user.send_confirmation_instructions
    user.confirm
    user
  end

  let(:recipe1) do
    Recipe.create(name: 'Apple Pie', preparation_time: 1, cooking_time: 2, description: 'A delicious apple pie recipe.', user_id: user1.id)
  end

  let!(:food1) { Food.create(name: 'Apple', quantity: 5, measurement_unit: 'pieces', price: 1, user_id: user1.id) }

  let!(:recipe_food1) { RecipeFood.create(recipe_id: recipe1.id, food_id: food1.id, quantity: 5) }

  before do
    login_as(user1, scope: :user)
  end

  it 'displays details of the public recipes' do
    visit public_recipes_path
    expect(page).to have_content('Public Recipes')
  end

  it 'displays recipe details including name and author' do
    visit public_recipes_path

    within('.card', text: 'Apple Pie') do
      expect(page).to have_content('Apple Pie')
      expect(page).to have_content('By: John Doe')
    end
  end

  it 'displays recipe statistics including total food items and total price' do
    visit public_recipes_path

    within('.card', text: 'Apple Pie') do
      expect(page).to have_content('Total Food items: 1')
      expect(page).to have_content('Total Price($): 5')
    end
  end

  it 'Should have delete link' do
    visit public_recipes_path

    within('.card', text: 'Apple Pie') do
      expect(page).to have_link('Delete Recipe', href: recipe_path(recipe1), class: 'btn btn-danger btn-sm')
    end
  end
end
