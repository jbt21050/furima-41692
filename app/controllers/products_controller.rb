class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @categories = Category.all
    @product_conditions = Product_condition.all
    @shipping_costs = Shipping_cost.all
    @shipping_regions = Shipping_region.all
    @delivery_times = Delivery_time.all
  end

  def create
    @product = Product.new(product_params)
    
    if @product.save
      redirect_to root_path, notice: '商品が出品されました'
    else
      @categories = Category.all
      @product_conditions = Product_condition.all
      @shipping_costs = Shipping_cost.all
      @shipping_regions = Shipping_region.all
      @delivery_times = Delivery_time.all
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
