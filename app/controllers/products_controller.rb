class Products_Controller < ApplicationController
  def index
    # @product = Product.all
  end
  private

  def message_params
    params.require(:product).permit(:content, :image).merge(user_id: current_user.id)
  end
end