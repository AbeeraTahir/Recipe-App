require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  subject do
    @user = User.create(name: 'Abeera')
    @food = Food.create(name: 'Mango', measurement_unit: 'kg', price: 10, quantity: 10, user: @user)
    @recipe = Recipe.create(name: 'recipe 1', preparation_time: 1, cooking_time: 2, description: 'abc', public: true, user: @user)
    @recipe_food = RecipeFood.create(quantity: 10, food: @food, recipe: @recipe)
  end

  before { subject.save }

  it 'quantity should be present' do
    subject.quantity = nil
    expect(subject).to_not be_valid
  end

  it 'quantity should have valid value' do
    expect(subject.quantity).to eql 10
  end

  it 'quantity should be a integer' do
    expect(subject.quantity).to be_a(Integer)
  end
end