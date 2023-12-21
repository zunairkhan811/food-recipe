class RecipesController < ApplicationController
  def index
    @recipes  = current_user.recipes
    # @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods
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

    if @recipe.public.zero?
      @recipe.update(public: 1)
      redirect_to @recipe, notice: 'Recipe public status was successfully updated.'
    elsif @recipe.public == 1
      @recipe.update(public: 0)
      redirect_to @recipe, notice: 'Recipe public status was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      redirect_to recipes_path, notice: 'Recipe deleted'
    else
      redirect_to recipes_path, alert: 'Recipe could not be deleted'
    end
  end

  def public_recipes
    @public_recipes = Recipe.where(public: true)
  end

end
