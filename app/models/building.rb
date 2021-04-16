class Building < ApplicationRecord

  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true, length: { maximum: 1000 }

  has_many_attached :photos

  has_many :offices, dependent: :destroy

end
