class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user
    puts "Food before save: #{@food.inspect}"
    if @food.save
      redirect_to foods_path, notice: 'Your food has been added successfully'
    else
      puts "Errors: #{@food.errors.full_messages.inspect}"
      render :new, alert: 'There is an error in adding a food'
    end
  end

  def new
    @food = Food.new
  end

  def destroy
    @food = Food.find(params[:id])
    authorize! :destroy, @food
    if @food.destroy
      redirect_to foods_path, notice: 'Food item is deleted'
    else
      redirect_to foods_path, alert: 'Error occured in deleting food item'
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :quantity, :measurement_unit, :price)
  end
end
