class Recipe < ApplicationRecord
  has_many :recipe_foods, class_name: 'RecipeFood', foreign_key: 'recipe_id'
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
end