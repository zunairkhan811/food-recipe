require 'rails_helper'

RSpec.describe 'Recipe Details Page', type: :system do
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

  it 'displays details of the recipe and its foods' do
    visit recipe_path(recipe1)
    expect(page).to have_content('Apple Pie')
    expect(page).to have_button('Edit', class: 'btn btn-warning')
    expect(page).to have_button('Delete', class: 'btn btn-danger')
  end
  it 'check' do
    visit recipe_path(recipe1)
    expect(page).to have_content('A delicious apple pie recipe.')
    expect(page).to have_content('Preparation Time: 1 minutes')
    expect(page).to have_content('Cooking Time: 2 minutes')
  end
  it 'check' do
    visit recipe_path(recipe1)
    expect(page).to have_content('Description: A delicious apple pie recipe.')
    expect(page).to have_content('Generate Shopping List')
    expect(page).to have_content('Add Ingredient')
  end
  it 'check' do
    visit recipe_path(recipe1)
    expect(page).to have_content('Apple')
    expect(page).to have_content('5')
  end
end
