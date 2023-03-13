class AddFoodRefToRecipeFoods < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipe_foods, :food, foreign_key: { to_table: 'foods' }
  end
end
