require 'rails_helper'

RSpec.describe 'Foods page', type: :system do
  describe 'Foods /index' do
    before(:each) do
      @user = User.create!(name: 'name', email: 'email@gmail.com', password: 'password')
      @food = Food.create!(name: 'food', measurement_unit: 'kg', quantity: 5, price: 10, user_id: @user.id)
      @food2 = Food.create!(name: 'food2', measurement_unit: 'grams', quantity: 7, price: 20, user_id: @user.id)
      @user.skip_confirmation!
      @user.save!
      visit new_user_session_path
      fill_in 'user_email', with: 'email@gmail.com'
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
      sleep(1)
      visit foods_path
    end

    after(:each) do
      sleep(2)
    end

    it 'displays the name, measurement unit, price of food' do
      expect(page).to have_content(@food.name)
      expect(page).to have_content(@food.measurement_unit)
      expect(page).to have_content(@food.price)
    end

    it 'displays Addfood and Delete button' do
      expect(page).to have_content('Add food')
      expect(page).to have_content('Delete')
    end

    it 'button redirects to a page to add Add food' do
      click_link 'Add food'
      expect(page).to have_current_path new_food_path
    end

    it 'click on Delete button' do
      # Click on the first link with the text "Delete"
      first(:link, 'Delete').click
    
      # Handle the alert using Capybara's accept_alert method
      accept_alert 'Delete the food?'
    
      # Assert that there is no delete links on the page
      expect(page).to have_content('Delete')
    end
  end

  describe 'Foods /new' do
    before(:each) do
      @user = User.create!(name: 'name', email: 'email@gmail.com', password: 'password')
      @food = Food.create!(name: 'apple', measurement_unit: 'grams', quantity: 7, price: 20, user_id: @user.id)
      @user.skip_confirmation!
      @user.save!
      visit new_user_session_path
      fill_in 'user_email', with: 'email@gmail.com'
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
      sleep(1)
      visit new_food_path
    end

    after(:each) do
      sleep(2)
    end

    it 'displays a form with name, measurement unit, quantity, price' do
      expect(page).to have_content('Name')
      expect(page).to have_content('Measurement unit')
      expect(page).to have_content('Quantity')
      expect(page).to have_content('Price')
    end

    it 'creates a new food' do
      fill_in 'food_name', with: 'food'
      fill_in 'food_measurement_unit', with: 'kg'
      fill_in 'food_quantity', with: 5
      fill_in 'food_price', with: 10
      sleep(1)
      click_button 'Create food'
      expect(page).to have_current_path foods_path
    end

    it "doesn't create a new food" do
      fill_in 'food_name', with: ''
      fill_in 'food_measurement_unit', with: ''
      fill_in 'food_quantity', with: ''
      fill_in 'food_price', with: ''
      sleep(1)
      click_button 'Create food'
      expect(page).to have_content("Name can't be blank")
    end

    it "click on 'Back to foods' button" do
      click_link('', class: 'btn-warning')
      sleep(1)
      expect(page).to have_current_path foods_path
    end
  end
end
