require 'rails_helper'

RSpec.describe Recipe, type: :model do
  subject do
    @user = User.create(name: 'Abeera')
    @recipe = Recipe.create(name: 'recipe 1', preparation_time: 1, cooking_time: 2, description: 'abc', public: true,
                            user: @user)
  end

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should have valid value' do
    expect(subject.name).to eql 'recipe 1'
  end

  it 'preparation time should be present' do
    subject.preparation_time = nil
    expect(subject).to_not be_valid
  end

  it 'preparation time should be an integer' do
    expect(subject.preparation_time).to be_an(Integer)
  end

  it 'preparation time should not be less than 1' do
    subject.preparation_time = -1
    expect(subject).to_not be_valid
  end

  it 'preparation time should have valid value' do
    expect(subject.preparation_time).to eql 1
  end

  it 'cooking time should be present' do
    subject.cooking_time = nil
    expect(subject).to_not be_valid
  end

  it 'cooking time should be an integer' do
    expect(subject.cooking_time).to be_an(Integer)
  end

  it 'cooking time must not be less than 1' do
    subject.cooking_time = -1
    expect(subject).to_not be_valid
  end

  it 'cooking time should have valid value' do
    expect(subject.cooking_time).to eql 2
  end

  it 'description should be present' do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it 'description should have valid value' do
    expect(subject.description).to eql 'abc'
  end

  it 'public should be a boolean' do
    expect(subject.public).to be(false).or be(true)
  end

  it 'public should have valid value' do
    expect(subject.public).to eql true
  end
end
