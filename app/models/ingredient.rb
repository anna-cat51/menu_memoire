class Ingredient < ApplicationRecord
  has_one :search_content
  has_many :repertoire_ingredients, dependent: :destroy, inverse_of: :ingredient
  has_many :repertoire, through: :repertoire_ingredients
  accepts_nested_attributes_for :repertoire_ingredients

  validates :name, uniqueness: true
end
