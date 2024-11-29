require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '商品出品機能' do
    before do
      @product = FactoryBot.build(:product)
    end

    context '商品出品が成功する場合' do
      it 'すべての情報が正しく入力されていれば出品できる' do
        expect(@product).to be_valid
      end
    end

    context '商品出品が失敗する場合' do
      it '商品画像が添付されていないと出品できない' do
        @product.image = nil
        @product.valid?  # エラーを検出するためにvalid?を呼び出し
        expect(@product.errors.full_messages).to include("Imageを入力してください")
      end

      it '商品名が空では出品できない' do
        @product.product_name = ''
        @product.valid?  # valid?を呼び出し
        expect(@product.errors.full_messages).to include("Product nameを入力してください")
      end

      it '商品の説明が空では出品できない' do
        @product.product_explanation = ''
        @product.valid?  # valid?を呼び出し
        expect(@product.errors.full_messages).to include("Product explanationを入力してください")
      end

      it 'カテゴリーが未選択（---）だと出品できない' do
        @product.category_id = 1
        @product.valid?  # valid?を呼び出し
        expect(@product.errors.full_messages).to include("Categoryを選択してください")
      end

      it '商品の状態が未選択（---）だと出品できない' do
        @product.product_condition_id = 1
        @product.valid?  # valid?を呼び出し
        expect(@product.errors.full_messages).to include("Product conditionを選択してください")
      end

      it '配送料の負担が未選択（---）だと出品できない' do
        @product.shipping_cost_id = 1
        @product.valid?  # valid?を呼び出し
        expect(@product.errors.full_messages).to include("Shipping costを選択してください")
      end

      it '発送元の地域が未選択（---）だと出品できない' do
        @product.product_condition_id = 1
        @product.valid?  # valid?を呼び出し
        expect(@product.errors.full_messages).to include("Product conditionを選択してください")
      end

      it '発送までの日数が未選択（---）だと出品できない' do
        @product.delivery_time_id = 1
        @product.valid?  # valid?を呼び出し
        expect(@product.errors.full_messages).to include("Delivery timeを選択してください")
      end

      it '価格が空では出品できない' do
        @product.sales_price = nil
        @product.valid?  # valid?を呼び出し
        expect(@product.errors.full_messages).to include("Sales priceを入力してください")
      end

      it '価格が300円未満では出品できない' do
        @product.sales_price = 299
        @product.valid?  # valid?を呼び出し
        expect(@product.errors.full_messages).to include("Sales priceは300~9,999,999の間で設定してください")
      end

      it '価格が9,999,999円を超えると出品できない' do
        @product.sales_price = 10_000_000
        @product.valid?  # valid?を呼び出し
        expect(@product.errors.full_messages).to include("Sales priceは300~9,999,999の間で設定してください")
      end

      it '価格が半角数値以外では出品できない' do
        @product.sales_price = '１０００'
        @product.valid?  # valid?を呼び出し
        expect(@product.errors.full_messages).to include("Sales priceは半角数値で入力してください")
      end

      it 'ユーザーが紐付いていないと出品できない' do
        @product.user = nil
        @product.valid?  # valid?を呼び出し
        expect(@product.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
