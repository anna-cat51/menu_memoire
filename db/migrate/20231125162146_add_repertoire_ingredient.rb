class AddRepertoireIngredient < ActiveRecord::Migration[7.0]
  def change
    add_index :repertoire_ingredients, %i[repertoire_id ingredient_id], unique: true,
                                                                        name: 'unique_repertoire_ingredient_index'
  end
end
