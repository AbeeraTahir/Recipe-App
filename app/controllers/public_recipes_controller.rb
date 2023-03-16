class PublicRecipesController < ApplicationController
  def index
    @users = User.all
    @public_recipes = Recipe.includes(%i[recipe_foods user]).where(public: true)
  end
end
