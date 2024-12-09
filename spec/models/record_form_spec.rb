require 'rails_helper'

RSpec.describe RecordForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @product = FactoryBot.create(:product, user: @user)
    @record_form = FactoryBot.build(:record_form, user_id: @user.id, product_id: @product.id)
  end

  describe '商品購入記録の保存' do
    context '購入が正常にできる場合' do
      it 'すべての値が正しく入力されていれば購入できる' do
        expect(@record_form).to be_valid
      end

      it '建物名が空でも購入できる' do
        @record_form.building_name = ''
        expect(@record_form).to be_valid
      end
    end

    context '購入ができない場合' do
      it '郵便番号が空では購入できない' do
        @record_form.post_code = ''
        @record_form.valid?
        expect(@record_form.errors.full_messages).to include("Post codeを入力してください")
      end

      it '郵便番号が「3桁ハイフン4桁」の形式でないと購入できない' do
        @record_form.post_code = '1234567'
        @record_form.valid?
        expect(@record_form.errors.full_messages).to include('Post codeは「123-4567」の形式で入力してください')
      end

      it '都道府県が「---」では購入できない' do
        @record_form.shipping_region_id = 1
        @record_form.valid?
        expect(@record_form.errors.full_messages).to include('Shipping regionを選択してください')
      end

      it '市区町村が空では購入できない' do
        @record_form.municipalities = ''
        @record_form.valid?
        expect(@record_form.errors.full_messages).to include("Municipalitiesを入力してください")
      end

      it '番地が空では購入できない' do
        @record_form.street_address = ''
        @record_form.valid?
        expect(@record_form.errors.full_messages).to include("Street addressを入力してください")
      end

      it '電話番号が空では購入できない' do
        @record_form.telephone_number = ''
        @record_form.valid?
        expect(@record_form.errors.full_messages).to include("Telephone numberを入力してください")
      end

      it '電話番号が9桁以下では購入できない' do
        @record_form.telephone_number = '090123456'
        @record_form.valid?
        expect(@record_form.errors.full_messages).to include('Telephone numberは10桁または11桁の半角数字で入力してください')
      end

      it '電話番号が12桁以上では購入できない' do
        @record_form.telephone_number = '090123456789'
        @record_form.valid?
        expect(@record_form.errors.full_messages).to include('Telephone numberは10桁または11桁の半角数字で入力してください')
      end

      it '電話番号に半角数字以外が含まれていると購入できない' do
        @record_form.telephone_number = '090-1234-5678'
        @record_form.valid?
        expect(@record_form.errors.full_messages).to include('Telephone numberは10桁または11桁の半角数字で入力してください')
      end

      it 'tokenが空では購入できない' do
        @record_form.payjp_token = ''
        @record_form.valid?
        expect(@record_form.errors.full_messages).to include("Payjp tokenを入力してください")
      end

      it 'user_idが紐付いていなければ購入できない' do
        @record_form.user_id = nil
        @record_form.valid?
        expect(@record_form.errors.full_messages).to include('Userを入力してください')
      end

      it 'product_idが紐付いていなければ購入できない' do
        @record_form.product_id = nil
        @record_form.valid?
        expect(@record_form.errors.full_messages).to include('Productを入力してください')
      end
    end
  end
end
