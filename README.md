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
| date_of_birth        | string | null: false               |

### Association

- has_many :products
- has_many :records

## products テーブル

| Column                | Type    | Options     |
| --------------------- | ------- | ----------- |
| product_name          | string  | null: false |
| product_explanation   | text    | null: false |
| category_id           | integer | null: false |
| product_condition_id  | integer | null: false |
| shipping_costs_id     | integer | null: false |
| shipping_region_id    | integer | null: false |
| delivery_time_id      | integer | null: false |
| sales_price           | integer | null: false |

### Association

- belongs_to :user
- belongs_to :record

## shipping_informations テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| post_code          | integer    | null: false                    |
| prefectures_id     | integer    | null: false                    |
| municipalities     | string     | null: false                    |
| street_address     | string     | null: false
| building_name      | string     |                                |
| telephone_number   | string     | null: false                    |
| record             | references | null: false, foreign_key: true |

### Association

- belongs_to :record

## records テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| product  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :product
- has_one :shipping_information