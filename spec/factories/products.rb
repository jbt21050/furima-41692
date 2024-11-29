FactoryBot.define do
  factory :product do
    product_name { "テスト商品" }
    product_explanation { "商品の説明文です" }
    category_id { 2 }
    product_condition_id { 2 }
    shipping_cost_id { 2 }
    shipping_region_id { 2 }
    delivery_time_id { 2 }
    sales_price { 1000 }
    association :user

    image { Rack::Test::UploadedFile.new('spec/fixtures/sample_image.png', 'image/png') }
  end
end
