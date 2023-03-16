class ShoppinglistsController < ApplicationController
  before_action :find_user

  def index
    @total_price = 0
    @recipe_foods = []
    @user.recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        @total_price += recipe_food.food.price * recipe_food.quantity
        @recipe_foods << recipe_food
      end
    end

    grouped_recipe_foods = @recipe_foods.group_by(&:food_id)
    updated_recipe_foods = []

    grouped_recipe_foods.each do |food_id, recipe_foods|
      quantity_sum = recipe_foods.sum(&:quantity)
      updated_recipe_foods << RecipeFood.new(food_id:, quantity: quantity_sum,
                                             recipe_id: recipe_foods.first.recipe_id)
    end

    @recipe_foods = updated_recipe_foods
  end

  private

  def find_user
    @user = current_user
  end

  def show
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
    @recipe_foods = @recipe.recipe_foods
  end
end
