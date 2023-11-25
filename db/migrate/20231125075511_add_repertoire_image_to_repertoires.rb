class AddRepertoireImageToRepertoires < ActiveRecord::Migration[7.0]
  def change
    add_column :repertoires, :repertoire_image, :string
  end
end
