class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  # アクティブハッシュモデルとの関連付け
  belongs_to :category
  belongs_to :product_condition
  belongs_to :shipping_cost
  belongs_to :shipping_region
  belongs_to :delivery_time

  # ユーザー関連
  belongs_to :user
  has_one_attached :image

  # バリデーション
  validates :category_id, :product_condition_id, :shipping_cost_id, :shipping_region_id, :delivery_time_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :product_name, :description, :category, :condition, :shipping_fee, :shipping_region, :shipping_days, :price, :image, presence: true
  validates :sales_price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: "は300~9,999,999の間で設定してください" }

  # 商品名（product_name）と価格（sales_price）の追加バリデーションなども必要に応じて
end
