class PublicRecipesController < ApplicationController
  before_action :set_user

  def index
    @users = User.all
    @public_recipes = Recipe.includes(%i[recipe_foods user]).where(public: true)
  end

  private

  def set_user
    @user = current_user
  end
end
