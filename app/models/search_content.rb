class SearchContent < ApplicationRecord
  belongs_to :repertoire, optional: true
  belongs_to :ingredient, optional: true


  validate :must_have_repertoire_or_ingredient

  private

  def must_have_repertoire_or_ingredient
    unless repertoire_id.present? || ingredient_id.present?
      errors.add(:base, "repertoireまたはingredientのどちらかは必須です')
    end
")
    end
  end
end
