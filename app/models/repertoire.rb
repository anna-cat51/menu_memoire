class Repertoire < ApplicationRecord
  belongs_to :user
  has_many :repertoire_ingredients, dependent: :destroy
  has_many :ingredients, through: :repertoire_ingredients
  mount_uploader :repertoire_image, RepertoireImageUploader

  validates :name, presence: true, length: { maximum: 255 }
  validates :recipe_url, length: { maximum: 255 }
  # 検索用のスコープ
  scope :with_ingredient, ->(ingredient_name) { joins(:ingredients).where(ingredients: { name: ingredient_name }) }
  scope :name_contain, ->(word) { where('name LIKE ?', "%#{word}%") }
  scope :of_user, ->(user) { where(user:) }

  # 食材をDBに保存する操作
  def save_with_ingredients(ingredient_names:)
    ActiveRecord::Base.transaction do
      # 存在しない食材があれば保存する
      self.ingredients = ingredient_names.map { |name| Ingredient.find_or_initialize_by(name: name.strip) }
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
end
