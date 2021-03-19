class Office < ApplicationRecord
  belongs_to :building

  validates :price, presence: true
  validates :places_number, presence: true, numericality: { only_integer: true }
  validates :name, presence: true

  enum office_type: { privates: 1, coworks: 2 }
end
