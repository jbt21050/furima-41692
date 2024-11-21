# テーブル設計

## users テーブル

| Column               | Type   | Options     |
| -------------------- | ------ | ----------- |
| nickname             | string | null: false |
| email                | string | null: false, unique: true |
| encrypted_password   | string | null: false |
| last_name            | string | null: false |
| first_name           | string | null: false |
| last_name_kana       | string | null: false |
| first_name_kana      | string | null: false |
| date_:of_birth       | string | null: false |

### Association

- has_many :products
- has_many :records

## products テーブル

| Column                | Type   | Options     |
| --------------------- | ------ | ----------- |
| product_name          | string | null: false |
| product_explanation   | string | null: false |
| category              | string | null: false |
| product_condition     | string | null: false |
| shipping_costs        | string | null: false |
| shipping_region       | string | null: false |
| delivery_time         | string | null: false |
| sales_price           | string | null: false |

### Association

- belongs_to :users
- belongs_to :records

## shipping_informations テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| post_code          | string     | null: false                    |
| prefectures        | string     | null: false                    |
| municipalities     | string     | null: false                    |
| building_name      | string     | null: false                    |
| telephone_number   | string     | null: false                    |
| record             | references | null: false, foreign_key: true |

### Association

- belongs_to :records

## records テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| product  | references | null: false, foreign_key: true |

### Association

- belongs_to :users
- belongs_to :products
- belongs_to :shipping_informations