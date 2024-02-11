class SearchContent < ApplicationRecord
  belongs_to :repertoire, optional: true
  belongs_to :ingredient, optional: true


  validate :must_have_repertoire_or_ingredient

  before_save :analyze_name

  # 検索用のスコープ
  # フルテキスト検索用スコープ
  scope :fulltext_search, ->(query_string) {
    where("MATCH(search_contents.repertoire_name, search_contents.ingredient_name) AGAINST(? IN BOOLEAN MODE)", query_string)
  }

  # N-gram検索用スコープ
  scope :ngram_search, ->(query_string) {
    where("MATCH(search_contents.repertoire_name_ngram, search_contents.ingredient_name_ngram) AGAINST(? IN BOOLEAN MODE)", query_string)
  }

  # LIKE検索用スコープ
  scope :like_search, ->(query_array) {
    conditions = query_array.map do |q|
      "(origin_repertoire_name LIKE '%#{q}%' OR origin_ingredient_name LIKE '%#{q}%')"
    end.join(" AND ")
    where(conditions)
  }

  def self.search(query_string)
    query_array = query_string.split(/[[:space:]]/)
    fulltext_search_result = fulltext_search(query_string)
    ngram_search_result = ngram_search(query_string)
    like_search_result = like_search(query_array)
    fulltext_search_result.or(ngram_search_result).or(like_search_result)
  end
  

  def self.ngram_or_like(query_array)
    if query_array.find { |q| q.size == 1 }
      like_search(query_array)
    else
      ngram_search(ngram_strings(query_array))
    end
  end

  def self.surface_and_yomi_strings(query_array)
    query_array.map { |q| "#{q} #{Analyze.parse(q, '-Oyomi')}" }
  end

  def self.ngram_strings(query_array)
    query_array.map { |q| "+#{Analyze.ngram(q, ' +')}" }
  end

  private

  def must_have_repertoire_or_ingredient
    unless repertoire_id.present? || ingredient_id.present?
      errors.add(:base, "repertoireまたはingredientのどちらかは必須です")
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
