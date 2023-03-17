require 'rails_helper'

RSpec.describe 'Recipes Page', type: :system do
  describe 'Public Recipe /index' do
    before(:each) do
      @user = User.create!(name: 'name', email: 'email@gmail.com', password: 'password')
      @food = Food.create!(name: 'food', measurement_unit: 'kg', quantity: 5, price: 10, user_id: @user.id)
      @recipe = Recipe.create!(name: 'recipe', preparation_time: 1, cooking_time: 2, description: 'description',
                               public: true, user_id: @user.id)
      @recipefood = RecipeFood.create!(quantity: 1, food_id: @food.id, recipe_id: @recipe.id)
      @user.skip_confirmation!
      @user.save!
      visit new_user_session_path
      fill_in 'user_email', with: 'email@gmail.com'
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
      sleep(1)
      visit public_recipes_path
    end

    after(:each) do
      sleep(2)
    end

    it "displays the recipe's name and user" do
      expect(page).to have_content(@recipe.name)
      expect(page).to have_content(@user.name.capitalize)
    end

    it 'displays the TOTAL FOOD ITEMS and TOTAL PRICE' do
      expect(page).to have_content(@recipefood.quantity)
      expect(page).to have_content(@recipefood.quantity * @food.price)
    end

    it 'redirects when click on NAME' do
      sleep(1)
      # Click on the link with class name "text-dark"
      click_link('', class: 'text-dark')
      expect(page).to have_current_path recipe_path(@recipe.id)
    end
  end
end
