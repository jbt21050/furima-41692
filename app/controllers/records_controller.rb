class RecordsController < ApplicationController
  def new
    @record_form = RecordForm.new
    @product = Product.find(params[:product_id]) # 商品情報取得

    gon.product_name = @product.product_name
    gon.product_price = @product.sales_price
  end

  def create
    @record_form = RecordForm.new(record_form_params)
    @record_form.user_id = current_user.id # ログイン中のユーザーを設定

    if @record_form.save
      redirect_to root_path, notice: "購入が完了しました！"
    else
      @product = Product.find(params[:product_id]) # エラー時に再取得
      render :new
    end
  end

  private

  def record_form_params
    params.require(:record_form).permit(
      :post_code, :shipping_region_id, :municipalities,
      :street_address, :building_name, :telephone_number, :product_id, :token
    )
  end
end
