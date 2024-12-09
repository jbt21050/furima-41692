# app/controllers/records_controller.rb
class RecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:index, :create]
  before_action :redirect_if_not_allowed, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY'] # PAY.JPの公開鍵を設定
    @record_form = RecordForm.new
  end

  def create
    @record_form = RecordForm.new(record_params)
    @record_form.user_id = current_user.id
    @record_form.product_id = @product.id

    if @record_form.valid?
      pay_item
      @record_form.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def redirect_if_not_allowed
    if current_user.id == @product.user_id || @product.record.present?
      redirect_to root_path
    end
  end

  def record_params
    params.require(:record_form).permit(
      :post_code, :shipping_region_id, :municipalities,
      :street_address, :building_name, :telephone_number,
      :payjp_token
    )
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
  
    begin
      charge = Payjp::Charge.create(
        amount: @product.sales_price,
        card: record_params[:payjp_token],
        currency: 'jpy'
      )
      return charge.paid
    rescue Payjp::PayjpError => e
      logger.error "Payment failed: #{e.message}"
      errors.add(:base, "Payment processing failed.")
      return false
    end
  end
end  
