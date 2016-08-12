class KitchenIngredient < ActiveRecord::Base
  belongs_to :kitchen
  belongs_to :ingredient
end
