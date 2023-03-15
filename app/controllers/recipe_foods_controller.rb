class RecipeFoodsController < ApplicationController
  def index
    @recipe_foods = RecipeFood.all
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @foods = Food.all
    if @recipe.user = current_user
      @recipe_food = RecipeFood.new
    else
      flash[:alert] = 'You do not have access to add an ingredient on a recipe that belongs to other Users.'
      redirect_to recipes_path
    end
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipe = @recipe

    if @recipe_food.save
      redirect_to recipe_path(@recipe), notice: 'New ingredient was successfully added.'
    else
      flash[:alert] = @recipe_food.errors.full_messages.first if @recipe_food.errors.any?
      redirect_to recipes_path
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end