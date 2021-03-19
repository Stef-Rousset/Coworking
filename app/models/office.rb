class Office < ApplicationRecord
  belongs_to :building

  validates :price, presence: true
  validates :places_number, presence: true, numericality: { only_integer: true }
  validates :name, presence: true

  scope :privates, -> { where("name LIKE ?", "%bureau%") }
  scope :coworks, -> { where("name LIKE ?", "%cowork%").first }
end
