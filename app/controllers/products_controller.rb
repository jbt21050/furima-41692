class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    
  end

  def create
    @product = Product.create(product_params)
    @product.user = current_user
    
    if @product.save
      redirect_to root_path, notice: '商品が出品されました'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private

  def product_params
    params.require(:product).permit(:product_name, :product_explanation, :category_id, :product_condition_id, :shipping_cost_id, :shipping_region_id, :delivery_time_id, :sales_price, :image)
  end
end
