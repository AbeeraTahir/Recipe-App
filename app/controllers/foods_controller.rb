class FoodsController < ApplicationController
  # before_action :set_food, only: %i[show edit update destroy]
  before_action :set_user, expect: [:update]

  # GET /foods or /foods.json
  def index
    # @foods = Food.all
    @foods = @user.foods.all
  end

  # GET /foods/1 or /foods/1.json
  def show
    @food = @user.foods.find(params[:id])
  end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit; end

  # POST /foods or /foods.json
  def create
    @food = Food.new(food_params)
    @food.user = @user

    if @food.save
      flash[:notice] = 'Food created successfully!'
      redirect_to foods_path
    else
      flash[:alert] = @food.errors.full_messages.first if @food.errors.any?
      # render :new, status: unprocessable_entity
      redirect_to foods_path
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    @food = Food.find(params[:id])

    if @food.destroy
      flash[:notice] = 'Food deleted successfully!'
      redirect_to foods_path
    else
      flash.now[:alert] = @food.errors.full_messages.first if @food.errors.any?
      render :index, status: 400
    end
  end

  private

  def set_user
    @user = current_user
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end
