class PublicRecipesController < ApplicationController
  def index
    @users = User.all
    @public_recipes = Recipe.where(public: true)
  end
end