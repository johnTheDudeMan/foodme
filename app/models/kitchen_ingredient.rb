class KitchenIngredient < ActiveRecord::Base
  belongs_to :kitchen
  belongs_to :ingredient

  # may not need this. see https://robots.thoughtbot.com/accepts-nested-attributes-for-with-has-many-through
  accepts_nested_attributes_for :kitchen
end
