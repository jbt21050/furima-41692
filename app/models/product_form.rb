class ProductForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :product_name, :product_explanation, :category_id, :product_condition_id,
                :shipping_cost_id, :shipping_region_id, :delivery_time_id, :sales_price, :image, :user, :product

  # バリデーション
  validates :product_name, :product_explanation, :category_id, :product_condition_id, 
            :shipping_cost_id, :shipping_region_id, :delivery_time_id, :sales_price, presence: true
  
  validates :category_id, :product_condition_id, :shipping_cost_id, :shipping_region_id, :delivery_time_id, 
            numericality: { other_than: 1, message: "を選択してください" }
  
  validates :sales_price, numericality: { 
    greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, 
    message: "は300~9,999,999の間で設定してください" 
  }
  validates :sales_price, numericality: { only_integer: true, message: "は半角数値で入力してください" }

  # 新規作成時に画像を必須にするバリデーション
  validates :image, presence: true, unless: :persisted?

  # persisted? メソッドで、レコードが新規か編集かを判定
  def persisted?
    product.present? && product.persisted?
  end

  # 保存処理
  def save
    return false unless valid?

    product = Product.create(
      product_name: product_name,
      product_explanation: product_explanation,
      category_id: category_id,
      product_condition_id: product_condition_id,
      shipping_cost_id: shipping_cost_id,
      shipping_region_id: shipping_region_id,
      delivery_time_id: delivery_time_id,
      sales_price: sales_price,
      user: user
    )

    # 新しい画像があれば添付する
    product.image.attach(image) if image.present?

    product
  end

  # 更新処理
  def update(params)
    return false unless valid?

    # 画像が新たにアップロードされていれば添付
    if params[:image].present?
      product.image.attach(params[:image]) # 新しい画像を添付
    end

    # 他の属性の更新
    product.update(
      product_name: params[:product_name],
      product_explanation: params[:product_explanation],
      category_id: params[:category_id],
      product_condition_id: params[:product_condition_id],
      shipping_cost_id: params[:shipping_cost_id],
      shipping_region_id: params[:shipping_region_id],
      delivery_time_id: params[:delivery_time_id],
      sales_price: params[:sales_price]
    )
  end
end
