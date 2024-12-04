class ShippingInformation < ApplicationRecord
  belongs_to :record

  # 配送先情報のバリデーション
  validates :post_code, :shipping_region_id, :municipalities, :street_address, :telephone_number, presence: true
  validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: "は正しい形式で入力してください" }
  validates :telephone_number, format: { with: /\A\d{10,11}\z/, message: "は10桁または11桁で入力してください" }
end
