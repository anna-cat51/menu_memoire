class Repertoire < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 255 }
  validates :recipe_url, presence: true, length: { maximum: 255 }
end
