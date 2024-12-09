FactoryBot.define do
  factory :record_form do
    post_code { '123-4567' }
    shipping_region_id { 2 }
    municipalities { 'Test City' }
    street_address { '1-1' }
    building_name { 'Test Building' }
    telephone_number { '09012345678' }
    payjp_token { 'tok_abcdefghijk00000000000000000' }
    user_id {  }
    product_id {  }
  end
end
