class Recipe < ApplicationRecord
  has_many :recipe_foods, class_name: 'RecipeFood', foreign_key: 'recipe_id'
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  validates :name, presence: true
  validates :description, presence: true
  validates :preparation_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cooking_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end