class User < ApplicationRecord
  enum role: { "一般": 0,"管理者":1 }

  #ADMIN権限かどうか？
  def admin?
    self.role == "管理者"
  end

  #ユーザー名による絞り込み 
  scope :get_by_name, ->(name) {
  where("name like ?", "%#{name}%")
  }

  #権限による絞り込み
  scope :get_by_role, ->(role) {
  where(role: role)
  }


   # validationの設定
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  # パスワード暗号化
  has_secure_password
  
  has_many :requests, foreign_key: 'user'
  # has_many :requests, foreign_key: 'charge_user'

end
