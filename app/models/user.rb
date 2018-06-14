class User < ApplicationRecord
  # validationの設定
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  # パスワード暗号化
  has_secure_password
  
  has_many :requests

end
