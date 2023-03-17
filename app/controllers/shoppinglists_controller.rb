class ShoppinglistsController < ApplicationController
  before_action :find_user

  def index
    # get all the recipe_foods from the user's recipes
    all_recipes

    # get total price
    calculate_total_price
  end

  def all_recipes
    @recipe_foods = RecipeFood.includes(:food, recipe: :user).where(recipes: { user_id: @user.id })
  end

  def calculate_total_price
    @total_price = 0
    @recipe_foods.each do |recipe_food|
      @total_price += recipe_food.food.price * recipe_food.quantity
    end
  end

  private

  def find_user
    @user = current_user
  end
end
