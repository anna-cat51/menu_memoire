class SearchContent < ApplicationRecord
  belongs_to :repertoire, optional: true
  belongs_to :ingredient, optional: true


  validate :must_have_repertoire_or_ingredient

  before_save :analyze_name

  # 検索用のスコープ
  # フルテキスト検索用スコープ
  scope :fulltext_search, ->(query_array) {
    conditions = query_array.map { |q|
      where("match(search_contents.repertoire_name,search_contents.ingredient_name) against(? in boolean mode)", q).where_values[0]
    }.join(" AND ")
    where(conditions)
  }

  # N-gram検索用スコープ
  scope :ngram_search, ->(query_array) {
    conditions = query_array.map { |n|
      where("match(search_contents.repertoire_name_ngram,search_contents.ingredient_name_ngram) against (? in boolean mode)", n).where_values[0]
    }.join(" AND ")
    where(conditions)
  }

  # LIKE検索用スコープ
  scope :like_search, ->(query_array) {
    repertoire_cont_all = query_array.map { |q| where("origin_repertoire_name LIKE ? ", "%#{q}%").where_values[0] }.join(" AND ")
    ingredient_cont_all = query_array.map { |q| where("origin_ingredient_name LIKE ? ", "%#{q}%").where_values[0] }.join(" AND ")
    where("(#{repertoire_cont_all}) OR (#{ingredient_cont_all})")
  }

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
