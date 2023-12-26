class RecipeFoodsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)

    if @recipe_food.save
      redirect_to recipe_path(@recipe), notice: 'Ingredient was successfully added.'
    else
      render :new
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    authorize! :destroy, @recipe_food
    if @recipe_food.destroy
      redirect_to request.referer, notice: 'Ingredient is deleted successfully.'
    else
      redirect_to request.referer, alert: 'Error occured in deleting ingredient.'
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:id, :recipe_id, :food_id, :quantity)
  end
end
