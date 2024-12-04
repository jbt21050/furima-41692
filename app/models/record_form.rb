class RecordForm
  include ActiveModel::Model

  # アトリビュート
  attr_accessor :user_id, :product_id, :post_code, :shipping_region_id, :municipalities,
                :street_address, :building_name, :telephone_number

  # バリデーション
  validates :post_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: 'は「3桁-4桁」の形式で入力してください' }
  validates :shipping_region_id, numericality: { other_than: 0, message: 'を選択してください' }
  validates :municipalities, :street_address, :telephone_number, presence: true
  validates :telephone_number, format: { with: /\A\d{10,11}\z/, message: 'は10桁または11桁の半角数字で入力してください' }

  def save
    ActiveRecord::Base.transaction do
      record = Record.create!(user_id: user_id, product_id: product_id)
      ShippingInformation.create!(
        post_code: post_code,
        shipping_region_id: shipping_region_id,
        municipalities: municipalities,
        street_address: street_address,
        building_name: building_name,
        telephone_number: telephone_number,
        record_id: record.id
      )
    end
  rescue ActiveRecord::RecordInvalid
    false
  end
end
