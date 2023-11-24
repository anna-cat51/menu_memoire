class CreateRepertoires < ActiveRecord::Migration[7.0]
  def change
    create_table :repertoires do |t|
      t.string :name
      t.string :recipe_url
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
