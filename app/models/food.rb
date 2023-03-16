class Food < ApplicationRecord
  has_many :recipe_foods, class_name: 'RecipeFood', foreign_key: 'food_id'
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  validates :name, presence: true, uniqueness: { scope: :measurement_unit, message: "must be unique within a measurement unit" }
  validates :measurement_unit, presence: true
  validates :price, presence: true, numericality: { only_float: true, greater_than_or_equal_to: 0 }
  validates :quantity, presence: true
end

