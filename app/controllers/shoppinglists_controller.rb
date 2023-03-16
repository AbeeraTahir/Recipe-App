class ShoppinglistsController < ApplicationController
  before_action :find_user

  def index
    # get all the recipe_foods from the user's recipes
    all_recipes

    # sum up the quantities of the same food
    sum_up_quantities

    # subtract the quantities of the foods that are already in the fridge
    subtract_existing_foods

    # get total price
    calculate_total_price
  end

  private

  def find_user
    @user = current_user
  end

  def all_recipes
    @recipe_foods = []
    @user.recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        @recipe_foods << recipe_food
      end
    end
  end

  def sum_up_quantities
    grouped_recipe_foods = @recipe_foods.group_by(&:food_id)
    updated_recipe_foods = []

    grouped_recipe_foods.each do |food_id, recipe_foods|
      quantity_sum = recipe_foods.sum(&:quantity)
      updated_recipe_foods << RecipeFood.new(food_id:, quantity: quantity_sum, recipe_id: recipe_foods.first.recipe_id)
    end

    @recipe_foods = updated_recipe_foods
  end

  def subtract_existing_foods
    @foods = Food.all

    @recipe_foods.each do |food1|
      food2 = @foods.find { |f| f.name == food1.food.name }
      food1.quantity -= food2.quantity if food2
    end
  end

  def calculate_total_price
    @total_price = 0
    @recipe_foods.each do |recipe_food|
      @total_price += recipe_food.food.price * recipe_food.quantity
    end
  end
end
