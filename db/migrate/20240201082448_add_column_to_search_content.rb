class AddColumnToSearchContent < ActiveRecord::Migration[7.0]
  def change
    add_column :search_contents, :repertoire_name_yomi, :string
    add_column :search_contents, :repertoire_name_ngram, :string
    add_column :search_contents, :ingredient_name_ngram, :string
  end
end
