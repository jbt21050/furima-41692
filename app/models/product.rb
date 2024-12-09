class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to :category
  belongs_to :product_condition
  belongs_to :shipping_cost
  belongs_to :shipping_region
  belongs_to :delivery_time

  belongs_to :user
  has_one :record
  has_one_attached :image
  

  validates :category_id, :product_condition_id, :shipping_cost_id, :shipping_region_id, :delivery_time_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :product_name, :product_explanation, :category, :product_condition, :shipping_cost, :shipping_region, :delivery_time, :sales_price, :image, presence: true
  validates :sales_price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: "は300~9,999,999の間で設定してください" }
  validates :sales_price, numericality: { only_integer: true, message: "は半角数値で入力してください" }

end
