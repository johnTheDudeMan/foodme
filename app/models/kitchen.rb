class Kitchen < ActiveRecord::Base
  belongs_to :user
  has_many :kitchen_ingredients
  has_many :ingredients, through: :kitchen_ingredients
end
