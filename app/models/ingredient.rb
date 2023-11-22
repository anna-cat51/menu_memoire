class Ingredient < ApplicationRecord
  has_many :repertoire_ingredients, dependent: :destroy
  has_many :repertoire, through: :repertoire_ingredients
  accepts_nested_attributes_for :repertoire_ingredients

  validates :name, presence: true, uniqueness: true
end
