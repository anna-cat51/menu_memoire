class RepertoireIngredient < ApplicationRecord
  belongs_to :repertoire
  belongs_to :ingredient
end
