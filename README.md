# テーブル設計

## users テーブル

| Column               | Type   | Options                   |
| -------------------- | ------ | ------------------------- |
| nickname             | string | null: false               |
| email                | string | null: false, unique: true |
| encrypted_password   | string | null: false               |
| last_name            | string | null: false               |
| first_name           | string | null: false               |
| last_name_kana       | string | null: false               |
| first_name_kana      | string | null: false               |
| date_of_birth        | date   | null: false               |

### Association

- has_many :products
- has_many :records

## products テーブル

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| product_name          | string     | null: false                    |
| product_explanation   | text       | null: false                    |
| category_id           | integer    | null: false                    |
| product_condition_id  | integer    | null: false                    |
| shipping_cost_id      | integer    | null: false                    |
| shipping_region_id    | integer    | null: false                    |
| delivery_time_id      | integer    | null: false                    |
| sales_price           | integer    | null: false                    |
| user_id               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :record

## shipping_informations テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| post_code          | string     | null: false                    |
| shipping_region_id | integer    | null: false                    |
| municipalities     | string     | null: false                    |
| street_address     | string     | null: false                    |
| building_name      | string     |                                |
| telephone_number   | string     | null: false                    |
| record_id          | references | null: false, foreign_key: true |

### Association

- belongs_to :record

## records テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| user_id    | references | null: false, foreign_key: true |
| product_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :product
- has_one :shipping_information