class Request < ApplicationRecord
  enum status: { "新規": 0,"対応中":1,"完了":2 }

  def self.title_search(search) #self.でクラスメソッドとしている
      Request.where(['title LIKE ?', "%#{search}%"]) 
  end
  
  def self.status_search(search) #self.でクラスメソッドとしている
      Request.where(['status = ?', search])
  end


  #リクエスｔの担当者を返す
  def charge_user_name
    if self.charge_user.nil?
      return self.charge_user.to_s
    else
      charge_user = User.find(self.charge_user)
      return charge_user.name
    end
  end


  belongs_to :user
  # belongs_to :charge_user, class_name: 'User' ,primary_key: 'charge_user'

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :message, length: { maximum: 255 }
end
