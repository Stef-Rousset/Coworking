class Building < ApplicationRecord

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :description, presence: true, length: { maximum: 1000 }

  has_one_attached :photo
end
