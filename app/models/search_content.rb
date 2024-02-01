class SearchContent < ApplicationRecord
  belongs_to :repertoire, optional: true
  belongs_to :ingredient, optional: true


  validate :must_have_repertoire_or_ingredient

  before_save :analyze_name
  private

  def must_have_repertoire_or_ingredient
    unless repertoire_id.present? || ingredient_id.present?
      errors.add(:base, "repertoireまたはingredientのどちらかは必須です')
    end
")
    end
  end

  def analyze_name
    if self.origin_repertoire_name.present?
      self.repertoire_name = Analyze.parse(self.origin_repertoire_name)
      self.repertoire_name_yomi = Analyze.parse(self.origin_repertoire_name, '-Oyomi')
      self.repertoire_name_ngram = Analyze.ngram(self.repertoire_name)
    end
    
    if self.origin_ingredient_name.present?
      self.ingredient_name = Analyze.parse(self.origin_ingredient_name)
      self.ingredient_name_ngram = Analyze.ngram(self.origin_ingredient_name)
    end
  end
end
