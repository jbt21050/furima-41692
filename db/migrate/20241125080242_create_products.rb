class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string  :product_name, null: false
      t.text :product_explanation, null: false
      t.integer :category_id, null: false
      t.integer  :product_condition_id, null: false
      t.integer :shipping_cost_id, null: false
      t.integer :shipping_region_id, null: false
      t.integer  :delivery_time_id, null: false
      t.integer :sales_price, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
