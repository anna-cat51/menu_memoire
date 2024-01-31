class Repertoire < ApplicationRecord
  has_one :search_content
  belongs_to :user
  has_many :repertoire_ingredients, dependent: :destroy
  has_many :ingredients, through: :repertoire_ingredients
  mount_uploader :repertoire_image, RepertoireImageUploader

  validates :name, presence: true, length: { maximum: 255 }
  validates :recipe_url, length: { maximum: 255 }

  after_save :repertoire_update_search_content
  after_destroy :repertoire_remove_search_content

  # 検索用のスコープ
  scope :with_ingredient, ->(ingredient_name) { joins(:ingredients).where(ingredients: { name: ingredient_name }) }
  scope :name_contain, ->(word) { where('name LIKE ?', "%#{word}%") }
  scope :of_user, ->(user) { where(user:) }

  # 食材をDBに保存する操作
  def save_with_ingredients(ingredient_names:)
    ActiveRecord::Base.transaction do
      # 存在しない食材があれば保存する
      self.ingredients = ingredient_names.map do |name|
        ingredient = Ingredient.find_or_initialize_by(name: name.strip)
        ingredient.save if ingredient.new_record? || ingredient.changed?
        update_search_content_for_ingredient(ingredient)
        ingredient
      end
      save!
    end
    true
  # トランザクション内でのエラーが発生した場合falseを返す
  rescue StandardError
    false
  end

  def ingredient_names
    # NOTE: pluckだと新規作成失敗時に値が残らない(返り値がnilになる)
    ingredients.map(&:name).join(',')
  end

  def repertoire_update_search_content
    child = SearchContent.find_or_initialize_by(repertoire_id: self.id)
    child.origin_repertoire_name = self.name
    unless child.save
      Rails.logger.error "SearchContent save failed: #{child.errors.full_messages.join(', ')}"
    end    
  end

  def repertoire_remove_search_content
    self.search_content.try(:destroy)
  end

  def update_search_content_for_ingredient(ingredient)
    search_content = SearchContent.find_or_initialize_by(ingredient_id: ingredient.id)
    search_content.origin_ingredient_name = ingredient.name
    unless search_content.save
      Rails.logger.error "Failed to save search content: #{search_content.errors.full_messages.join(', ')}"
    end
  end

end
