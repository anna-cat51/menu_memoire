class Repertoire < ApplicationRecord
  belongs_to :user
  has_many :repertoire_ingredients, dependent: :destroy
  has_many :ingredients, through: :repertoire_ingredients

  validates :name, presence: true, length: { maximum: 255 }
  validates :recipe_url, length: { maximum: 255 }
end
