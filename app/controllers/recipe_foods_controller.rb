class RecipeFoodsController < ApplicationController
  before_action :find_recipe
  before_action :find_recipe_food, only: %i[edit update destroy]

  def new
    @foods = current_user.foods
    if @recipe.user = current_user
      @recipe_food = RecipeFood.new
    else
      flash[:alert] = 'You cannot access an ingredient on a recipe that belongs to other Users.'
      redirect_to recipes_path
    end
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipe = @recipe

    if @recipe_food.save
      redirect_to recipe_path(@recipe), notice: 'New ingredient was successfully added.'
    else
      flash[:alert] = @recipe_food.errors.full_messages.first if @recipe_food.errors.any?
      redirect_to recipes_path
    end
  end

  def edit
    @foods = current_user.foods
  end
  
  def update
    if @recipe_food.update(recipe_food_params)
      redirect_to recipe_path(@recipe), notice: 'Ingredient was successfully updated.'
    else
      flash[:alert] = @recipe_food.errors.full_messages.first if @recipe_food.errors.any?
      render :edit, status: 400
    end
  end

  def destroy
    unless @recipe_food.recipe.user == current_user
      flash[:alert] ='You cannot delete the ingredient belongs to other Users.'
      return redirect_to recipe_path(@recipe)
    end

    if @recipe_food.destroy
      flash[:notice] = 'Ingredient deleted successfully removed.'
    else
      flash[:alert] = @recipe_food.errors.full_messages.first if @recipe_food.errors.any?
    end
    redirect_to recipe_path(@recipe)
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end

  def find_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def find_recipe_food
    @recipe_food = RecipeFood.find(params[:id])
  end
end