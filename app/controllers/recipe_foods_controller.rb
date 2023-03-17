class RecipeFoodsController < ApplicationController
  before_action :find_recipe
  before_action :find_recipe_food, only: %i[edit update destroy]
  before_action :set_user

  def new
    @foods = current_user.foods
    if @recipe.user == current_user
      @recipe_food = RecipeFood.new
    else
      flash[:alert] = 'You cannot add an ingredient on a recipe that belongs to other Users.'
      redirect_to recipe_path(@recipe)
    end
  end

  def create
    existing_recipe_food = RecipeFood.find_by(food_id: recipe_food_params[:food_id], recipe_id: @recipe.id)

    if existing_recipe_food.present?
      redirect_to recipe_path(@recipe), alert: 'Ingredient already exists'
    else
      @recipe_user_food = Food.find(recipe_food_params[:food_id])
      unless @recipe_user_food.quantity >= recipe_food_params[:quantity].to_i
        return redirect_to recipe_path(@recipe), alert: 'Quantity in stock is less.'
      end

      @recipe_food = RecipeFood.new(recipe_food_params)
      @recipe_food.recipe = @recipe

      if @recipe_food.save
        redirect_to recipe_path(@recipe), notice: 'New ingredient was successfully added.'
        @recipe_user_food.quantity -= recipe_food_params[:quantity].to_i
        @recipe_user_food.save
      else
        flash[:alert] = @recipe_food.errors.full_messages.first if @recipe_food.errors.any?
        redirect_to recipes_path
      end
    end
  end

  def edit
    unless @recipe_food.recipe.user == current_user
      flash[:alert] = 'You cannot modify the ingredient that belongs to other Users.'
      return redirect_to recipe_path(@recipe)
    end

    @foods = current_user.foods
  end

  def update
    @recipe_user_food = Food.find(recipe_food_params[:food_id])
    unless @recipe_user_food.quantity >= recipe_food_params[:quantity].to_i
      return redirect_to recipe_path(@recipe), alert: 'Quantity in stock is less.'
    end

    if @recipe_food.update(recipe_food_params)
      redirect_to recipe_path(@recipe), notice: 'Ingredient was successfully modified.'
      @recipe_user_food.quantity -= recipe_food_params[:quantity].to_i
      @recipe_user_food.save
    else
      flash[:alert] = @recipe_food.errors.full_messages.first if @recipe_food.errors.any?
      render :edit, status: 400
    end
  end

  def destroy
    unless @recipe_food.recipe.user == current_user
      flash[:alert] = 'You cannot remove the ingredient that belongs to other Users.'
      return redirect_to recipe_path(@recipe)
    end

    if @recipe_food.destroy
      flash[:notice] = 'Ingredient was successfully removed.'
    elsif @recipe_food.errors.any?
      flash[:alert] = @recipe_food.errors.full_messages.first
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

  def set_user
    @user = current_user
  end
end
