class ShippingInformation < ApplicationRecord
  belongs_to :record

  validates :quantity, presence: true
  validates :price, presence: true

end
