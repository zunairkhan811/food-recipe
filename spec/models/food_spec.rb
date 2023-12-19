require 'rails_helper'

RSpec.describe Food, type: :model do
  it 'name, measurement_unit, price, user should be present' do
    user = User.new(name: 'Acacia', email: 'acacia@email')
    food = Food.new(name: 'Chicken', measurement_unit: 'g', quantity: '200', price: '0.4', user:)
    expect(food).to be_valid
  end

  it 'name should be present' do
    user = User.new(name: 'Acacia', email: 'acacia@email')
    food = Food.new(measurement_unit: 'g', price: '0.7', user:)
    expect(food).to_not be_valid
  end

  it 'measurment_unit should be present' do
    user = User.new(name: 'Acacia', email: 'acacia@email')
    food = Food.new(name: 'Beef', price: '0.7', user:)
    expect(food).to_not be_valid
  end

  it 'price should be present' do
    user = User.new(name: 'Acacia', email: 'acacia@email')
    food = Food.new(name: 'Beef', measurement_unit: 'g', user:)
    expect(food).to_not be_valid
  end

  it 'price should be positive' do
    user = User.new(name: 'Acacia', email: 'acacia@email')
    food = Food.new(name: 'Beef', measurement_unit: 'g', price: '-0.7', user:)
    expect(food).to_not be_valid
  end

  it 'user should be present' do
    food = Food.new(name: 'Beef', measurement_unit: 'g', price: '0.7')
    expect(food).to_not be_valid
  end
end
