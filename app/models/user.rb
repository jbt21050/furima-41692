class User < ApplicationRecord
  has_many :products
  has_many :records
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :date_of_birth, presence: true

  PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は英字と数字の両方を含めて設定してください'

  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  validates :last_name, :first_name, format: { with: NAME_REGEX, message: 'は全角文字で入力してください' }

  KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze
  validates :last_name_kana, :first_name_kana, format: { with: KANA_REGEX, message: 'は全角カタカナで入力してください' }
end
