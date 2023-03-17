require 'rails_helper'

RSpec.describe Food, type: :model do
  subject do
    @user = User.create(name: 'Abeera')
    @food = Food.create(name: 'Mango', measurement_unit: 'kg', price: 10, quantity: 10, user: @user)
  end

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should have valid value' do
    expect(subject.name).to eql 'Mango'
  end

  it 'measurement unit should be present' do
    subject.measurement_unit = nil
    expect(subject).to_not be_valid
  end

  it 'measurement unit should have a valid value' do
    expect(subject.measurement_unit).to eql 'kg'
  end

  it 'price should be present' do
    subject.price = nil
    expect(subject).to_not be_valid
  end

  it 'price should have a valid value' do
    expect(subject.price).to eql 10
  end

  it 'quantity should be present' do
    subject.quantity = nil
    expect(subject).to_not be_valid
  end

  it 'quantity should have a valid value' do
    expect(subject.quantity).to eql 10
  end
end
