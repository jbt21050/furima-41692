class RecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:new, :create]
  before_action :check_product_availability, only: [:new, :create]

  def set_product
    @product = Product.find(params[:product_id])
  end

  def check_product_availability
    if !@product || @product.user == current_user
      redirect_to root_path, alert: '購入できない商品です。'
    end
  end

  
  def new
    @record = Record.new
    @shipping_information = @record.build_shipping_information
  end

  def create
    @record = Record.new(user: current_user, product: @product)
    @shipping_information = @record.build_shipping_information(shipping_information_params)

    if @record.save && @shipping_information.save
      # 支払い処理（PAY.JPなど）をここで実装
      redirect_to root_path, notice: '購入が完了しました！'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  # def check_product_availability
  #   if !@product || @product.sold_out? || @product.user == current_user
  #     redirect_to root_path, alert: '購入できない商品です。'
  #   end
  # end

  def shipping_information_params
    params.require(:shipping_information).permit(:post_code, :shipping_region_id, :municipalities, :street_address, :building_name, :telephone_number)
  end
end
