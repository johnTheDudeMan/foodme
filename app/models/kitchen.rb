# FIX: delete_all on kitchen_ingredients does not get called when destroying kitchen

class Kitchen < ActiveRecord::Base
  belongs_to :user
  has_many :kitchen_ingredients, dependent: :destroy
  has_many :ingredients, through: :kitchen_ingredients

  # see https://robots.thoughtbot.com/accepts-nested-attributes-for-with-has-many-through
  accepts_nested_attributes_for :kitchen_ingredients

  
end
