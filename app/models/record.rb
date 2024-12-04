class Record < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :shipping_information

  # 購入に関するバリデーション
  validates :user_id, :product_id, presence: true
end
