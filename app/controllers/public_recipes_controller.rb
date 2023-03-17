class PublicRecipesController < ApplicationController
  before_action :set_user

  def index
    @public_recipes = Recipe.includes(recipe_foods: :food).where(public: true)
  end

  private

  def set_user
    @user = current_user
  end
end
