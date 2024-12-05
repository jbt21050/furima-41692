class RecordForm
  include ActiveModel::Model

  # 仮想的な属性を定義（フォームで使用する全ての項目を記載）
  attr_accessor :user_id, :product_id, :post_code, :shipping_region_id, :municipalities, :street_address, :building_name, :telephone_number, :token

  # バリデーションの設定
  validates :post_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: "はハイフンを含めて入力してください" }
  validates :shipping_region_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :municipalities, :street_address, :telephone_number, :token, presence: true
  validates :telephone_number, format: { with: /\A\d{10,11}\z/, message: "は10桁または11桁の数字で入力してください" }

  # 保存処理
  def save
    # `records` テーブルに購入情報を保存
    record = Record.create(user_id: user_id, product_id: product_id)

    # `shipping_informations` テーブルに発送先情報を保存
    ShippingInformation.create(
      post_code: post_code,
      shipping_region_id: shipping_region_id,
      municipalities: municipalities,
      street_address: street_address,
      building_name: building_name,
      telephone_number: telephone_number,
      record_id: record.id
    )
  end
end
