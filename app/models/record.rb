class Record < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :shipping_information
  
  validates :total_price, presence: true
  validates :status, presence: true  # 'pending', 'paid', 'shipped' などのステータス

  # 合計金額を計算するメソッド
  def calculate_total_price
    self.total_price = order_items.sum(&:price)
  end
end

