require 'rails_helper'

RSpec.describe 'Recipe Index Page', type: :system do
  let(:user1) do
    user = User.create(name: 'John Doe', email: 'ali@gmail.com', password: 'password', password_confirmation: 'password')
    user.send_confirmation_instructions
    user.confirm
    user
  end

  let(:recipe1) do
    Recipe.create(name: 'Apple Pie', preparation_time: 1, cooking_time: 2, description: 'A delicious apple pie recipe.', user_id: user1.id)
  end

  before do
    login_as(user1, scope: :user)
    recipe1.save
  end

  it 'displays the "Add New Recipe" button' do
    visit recipes_path
    expect(page).to have_link('Add New Recipe', href: new_recipe_path)
  end

  it 'displays details of each recipe' do
    visit recipes_path

    within(".card", text: 'Apple Pie') do
      expect(page).to have_content('Apple Pie')
      expect(page).to have_content('A delicious apple pie recipe.')
      expect(page).to have_button('REMOVE', class: 'btn btn-danger btn-sm')
    end
  end
  it 'removes a recipe when "REMOVE" button is clicked' do
    visit recipes_path
    expect(page).to have_content('Apple Pie')
    click_button('REMOVE')
    expect(page).not_to have_content('Apple Pie')
  end
end
