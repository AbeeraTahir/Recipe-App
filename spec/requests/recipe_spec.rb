require 'rails_helper'

RSpec.describe 'Recipes Page', type: :system do
  describe 'Recipe /index' do
    before(:each) do
      @user = User.create!(name: 'name', email: 'email@gmail.com', password: 'password')
      @recipe = Recipe.create!(name: 'recipe', preparation_time: 1, cooking_time: 2, description: 'description',
                               public: true, user_id: @user.id)
      @recipe2 = Recipe.create!(name: 'recipe2', preparation_time: 1, cooking_time: 2, description: 'description2',
                                public: true, user_id: @user.id)
      @user.skip_confirmation!
      @user.save!
      visit new_user_session_path
      fill_in 'user_email', with: 'email@gmail.com'
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
      sleep(1)
      visit recipes_path
    end

    after(:each) do
      sleep(2)
    end

    it 'displays the recipe`s name and description' do
      expect(page).to have_content(@recipe.name)
      expect(page).to have_content(@recipe.description)
    end

    it 'displays buttons with text Delete, View and `Add a new recipe`' do
      expect(page).to have_content('Delete')
      expect(page).to have_content('View')
    end

    it 'button redirects to a page to `add new recipe`' do
      sleep(1)
      click_link 'Add a new recipe'
      expect(page).to have_current_path new_recipe_path
    end

    it 'click on Delete button' do
      # Click on the first link with the text "Delete"
      first(:link, 'Delete').click
      sleep(1)
      # Handle the alert
      page.driver.browser.switch_to.alert.accept

      # Assert that there is a delete links on the page
      expect(page).to have_content('Delete')
    end

    it 'click on View button' do
      sleep(1)
      # Click on the first link with the text "Delete"
      first(:link, 'View').click
      expect(page).to have_current_path recipe_path(@recipe.id)
    end
  end

  describe 'Recipe /new' do
    before(:each) do
      @user = User.create!(name: 'name', email: 'email@gmail.com', password: 'password')
      @recipe = Recipe.create!(name: 'recipe', preparation_time: 1, cooking_time: 2, description: 'description',
                               public: true, user_id: @user.id)
      @user.skip_confirmation!
      @user.save!
      visit new_user_session_path
      fill_in 'user_email', with: 'email@gmail.com'
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
      sleep(1)
      visit recipes_path
      sleep(1)
      visit new_recipe_path
    end

    after(:each) do
      sleep(2)
    end

    it "doesn't create a new recipe" do
      fill_in 'recipe_name', with: ''
      fill_in 'recipe_preparation_time', with: 1
      fill_in 'recipe_cooking_time', with: 2
      fill_in 'recipe_description', with: 'description'
      click_button 'Create recipe'
      expect(page).to have_content("Name can't be blank")
    end

    it 'creates a new recipe' do
      fill_in 'recipe_name', with: 'sea recipe'
      fill_in 'recipe_preparation_time', with: 1
      fill_in 'recipe_cooking_time', with: 2
      fill_in 'recipe_description', with: 'description'
      click_button 'Create recipe'
      expect(page).to have_content('Recipe created successfully!')
    end

    it "doesn't create a new recipe with a name that already exists" do
      fill_in 'recipe_name', with: 'recipe'
      fill_in 'recipe_preparation_time', with: 1
      fill_in 'recipe_cooking_time', with: 2
      fill_in 'recipe_description', with: 'description'
      click_button 'Create recipe'
      expect(page).to have_content('Name has already been taken')
    end

    it "doesn't create a new recipe with a negative preparation time" do
      fill_in 'recipe_name', with: 'sea recipe'
      fill_in 'recipe_preparation_time', with: -1
      fill_in 'recipe_cooking_time', with: 2
      fill_in 'recipe_description', with: 'description'
      click_button 'Create recipe'
      expect(page).to have_content('Preparation time must be greater than or equal to 0')
    end

    it "doesn't create a new recipe with a negative cooking time" do
      fill_in 'recipe_name', with: 'sea recipe'
      fill_in 'recipe_preparation_time', with: 1
      fill_in 'recipe_cooking_time', with: -2
      fill_in 'recipe_description', with: 'description'
      click_button 'Create recipe'
      expect(page).to have_content('Cooking time must be greater than or equal to 0')
    end

    it "click on 'Back to recipes' button" do
      click_link 'Back to recipes'
      expect(page).to have_current_path recipes_path
    end
  end
end
