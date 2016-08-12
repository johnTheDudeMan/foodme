class Ingredient < ActiveRecord::Base
  has_many :kitchen_ingredients
  has_many :kitchens, through: :kitchen_ingredients
end
