class KitchensController < ApplicationController

  def new
    @ingredient = KitchenIngedient.new
  end

  # make a kitchen_ingredients controller instead. 

end
