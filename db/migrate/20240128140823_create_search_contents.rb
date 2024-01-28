class CreateSearchContents < ActiveRecord::Migration[7.0]
  def change
    create_table :search_contents do |t|
      t.references :repertoire, foreign_key: true
      t.references :ingredient, foreign_key: true
      t.string :origin_repertoire_name
       t.string :repertoire_name
      t.text :origin_ingredient_name
      t.text :ingredient_name
    end
  end
end
