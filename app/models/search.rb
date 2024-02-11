class Search
  include ActiveModel::Model

  attr_accessor :word
  validates :word, presence: true

  def repertoires
    ingredient_ids = Ingredient.joins(:search_content).merge(SearchContent.search(word)).pluck(:ingredient_id)
    repertoires_for_ingredients = Repertoire.for_ingredient_ids(ingredient_ids)
    repertoires_direct = Repertoire.joins(:search_content).merge(SearchContent.search(word))
    Repertoire.where(id: repertoires_for_ingredients.pluck(:id) + repertoires_direct.pluck(:id)).distinct
  end
end