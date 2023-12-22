require 'rails_helper'

RSpec.describe 'Food Index Page', type: :system do
  let(:user1) do
    user = User.create(name: 'John Doe', email: 'ali@gmail.com', password: 'password', password_confirmation: 'password')
    user.send_confirmation_instructions
    user
  end

  before do
    user1.confirm
    login_as(user1, scope: :user)
  end

  subject do
    Food.create(name: 'Apple', quantity: 5, measurement_unit: 'pieces', price: 1, user_id: user1.id)
    Food.create(name: 'Orange', quantity: 7, measurement_unit: 'kg', price: 2, user_id: user1.id)
  end

  before { subject.save }

  it 'displays the "Add Food" button' do
    visit foods_path
    expect(page).to have_link('Add Food', href: new_food_path)
  end

  it 'displays details of each food item' do
    visit foods_path
    expect(page).to have_content('Apple')
    expect(page).to have_content('5')
    expect(page).to have_content('pieces')
    expect(page).to have_content('1') 
  end
  it 'displays details of each food item' do
    visit foods_path
    expect(page).to have_content('Orange')
    expect(page).to have_content('7')
    expect(page).to have_content('kg')
    expect(page).to have_content('2') 
  end
end
