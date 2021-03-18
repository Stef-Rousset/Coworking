class Office < ApplicationRecord
  belongs_to :building

  validates :price, presence: true
  validates :space, presence: true

  scope :alone, -> { where(space: "alone") }
  scope :cowork, -> { where(space: "cowork")}

end
