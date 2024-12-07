class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :redirect_if_sold_out, only: [:edit, :update]

  def index
    @products = Product.order(created_at: :desc)
  end

  def new
    @product = Product.new
  end

  def show
    
  end

  def edit
    
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
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

  def destroy
    if @product.destroy
      redirect_to root_path
    else
      redirect_to product_path(@product)
    end
  end
  
  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:product_name, :product_explanation, :category_id, :product_condition_id, :shipping_cost_id, :shipping_region_id, :delivery_time_id, :sales_price, :image)
  end

  def authorize_user
    redirect_to root_path, alert: '権限がありません。' unless current_user == @product.user
  end
end

def redirect_if_sold_out
  product = Product.find(params[:id])
  if product.record.present?
    redirect_to root_path, alert: '売却済み商品の編集はできません。'
  end
end

