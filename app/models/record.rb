class Record < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :shipping_information
end
