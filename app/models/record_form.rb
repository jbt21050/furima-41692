class RecordForm
  include ActiveModel::Model

  # 保存したいカラムをすべて列挙
  attr_accessor :user_id, :product_id, :post_code, :shipping_region_id, :municipalities,
                :street_address, :building_name, :telephone_number, :token
  
  attr_accessor :shipping_information

  def initialize(attributes = {})
    super
    @shipping_information = ShippingInformation.new(attributes[:shipping_information_attributes])
  end

  # バリデーション設定
  with_options presence: true do
    validates :user_id
    validates :product_id
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'は「123-4567」の形式で入力してください' }
    validates :shipping_region_id, numericality: { other_than: 0, message: 'を選択してください' }
    validates :municipalities
    validates :street_address
    validates :telephone_number, format: { with: /\A\d{10,11}\z/, message: 'は10桁または11桁の半角数字で入力してください' }
    validates :token
  end

  # データ保存処理
  def save
    record = Record.create(user_id: user_id, product_id: product_id)
    ShippingInformation.create(
      post_code: post_code, shipping_region_id: shipping_region_id,
      municipalities: municipalities, street_address: street_address,
      building_name: building_name, telephone_number: telephone_number,
      record_id: record.id
    )
  end
end
