class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods
    recipe_shopping_list
  end

  def create
    @recipe = Recipe.new(params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id))
    @recipe.user = current_user
    if @recipe.save
      redirect_to recipes_path
    else
      render :new
    end
  end

  def new
    @recipe = Recipe.new
  end

  def update
    @recipe = Recipe.find(params[:id])
    authorize! :update, @recipe

    if @recipe.public.zero?
      if @recipe.update(public: 1)
        render json: { success: true, message: 'Recipe public status was successfully updated.' }
      else
        render json: { success: false, errors: @recipe.errors.full_messages }, status: :unprocessable_entity
      end
    elsif @recipe.public == 1
      if @recipe.update(public: 0)
        render json: { success: true, message: 'Recipe public status was successfully updated.' }
      else
        render json: { success: false, errors: @recipe.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { success: false, errors: ['Invalid public status.'] }, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    authorize! :destroy, @recipe
    if @recipe.destroy
      redirect_to recipes_path, notice: 'Recipe deleted'
    else
      redirect_to recipes_path, alert: 'Recipe could not be deleted'
    end
  end

  def public_recipes
    @public_recipes = Recipe.includes(:user).where(public: true).order(created_at: :desc)
    authorize! :read, Recipe
  end

  def recipe_shopping_list
    @recipe_quantity = @recipe_foods.group(:food_id).sum(:quantity)
    @foods = current_user.foods
    @buy_items = []
    @total_quantity = 0
    @total_price = 0

    @foods.each do |food|
      next unless @recipe_quantity[food.id].present? && @recipe_quantity[food.id] > food.quantity

      food_quantity = @recipe_quantity[food.id] - food.quantity
      food_item = { name: food.name, quantity: food_quantity, value: food_quantity * food.price }
      @buy_items << food_item
      if food_quantity.positive?
        @total_quantity += food_quantity
        @total_price += food_quantity * food.price
      end
    end
  end
end
