class PublicRecipesController < ApplicationController
  before_action :set_user, expect: [:update]

  def index
    @users = User.all
    @public_recipes = Recipe.where(public: true)
  end

  private

  def set_user
    @user = current_user
  end
end
