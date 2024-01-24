class RepertoireIngredient < ApplicationRecord
  belongs_to :repertoire
  belongs_to :ingredient

  validates :ingredient_id, uniqueness: { scope: :repertoire_id }
end
