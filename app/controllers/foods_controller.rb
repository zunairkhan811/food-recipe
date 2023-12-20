class FoodsController < ApplicationController
    
    def index
      @foods = Food.all
    end

    def create
        @food = Food.new(food_params)
        if @food.save
         redirect_to foods_path, notice: "Your food has been added successfully"
        else
         render :new, notice: "There is an error in adding a food"
        end
    end

    def new
      @food = Food.new
    end

    private 
    def food_params
        params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
    end
end
