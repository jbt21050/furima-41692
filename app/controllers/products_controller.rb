class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @products = Product.order(created_at: :desc)
  end

  def new
    @product_form = ProductForm.new
  end

  def show
    
  end

  def edit
    @product = Product.find(params[:id])
    @product_form = ProductForm.new(
      product_name: @product.product_name,
      product_explanation: @product.product_explanation,
      category_id: @product.category_id,
      product_condition_id: @product.product_condition_id,
      shipping_cost_id: @product.shipping_cost_id,
      shipping_region_id: @product.shipping_region_id,
      delivery_time_id: @product.delivery_time_id,
      sales_price: @product.sales_price,
      image: @product.image.attached? ? @product.image : nil,
      product: @product
    )
  end

  def update
    @product = Product.find(params[:id])
    @product_form = ProductForm.new(product_params.merge(product: @product))

    if @product_form.update(product_params)
      redirect_to product_path(@product), notice: '商品情報が更新されました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  
  def create
    @product_form = ProductForm.new(product_params)
    @product_form.user = current_user
    
    if @product_form.save
      redirect_to root_path, notice: '商品が出品されました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      redirect_to root_path, notice: '商品を削除しました'
    else
      redirect_to product_path(@product), alert: '商品の削除に失敗しました'
    end
  end
  
  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product_form).permit(:product_name, :product_explanation, :category_id, :product_condition_id, :shipping_cost_id, :shipping_region_id, :delivery_time_id, :sales_price, :image)
  end

  def authorize_user
    redirect_to root_path, alert: '権限がありません。' unless current_user == @product.user
  end
end
