class Search
  include ActiveModel::Model

  attr_accessor :word
  validates :word, presence: true

  def repertoires
    Repertoire.joins(:search_content).merge(SearchContent.search(word))
  end

  def ingredients
    Ingredient.joins(:search_content).merge(SearchContent.search(word))
  end
end