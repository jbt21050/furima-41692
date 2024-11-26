class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @categories = Category.all
    @product_conditions = ProductCondition.all
    @shipping_costs = ShippingCost.all
    @shipping_regions = ShippingRegion.all
    @delivery_times = DeliveryTime.all
  end

  def create
    @product = Product.new(product_params)
    
    if @product.save
      redirect_to root_path, notice: '商品が出品されました'
    else
      @categories = Category.all
      @product_conditions = ProductCondition.all
      @shipping_costs = ShippingCost.all
      @shipping_regions = ShippingRegion.all
      @delivery_times = DeliveryTime.all
      render :new
    end
  end
  
  private

  def product_params
    # 必要なパラメータに画像も含める
    params.require(:product).permit(:product_name, :product_explanation, :category_id, :product_condition_id, 
                                    :shipping_cost_id, :shipping_region_id, :delivery_time_id, :sales_price, :image)
          .merge(user_id: current_user.id)
  end
end
