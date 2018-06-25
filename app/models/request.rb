class Request < ApplicationRecord
  enum status: { "新規": 0,"対応中":1,"完了":2 }


  belongs_to :user
  # belongs_to :charge_user, class_name: 'User' ,primary_key: 'charge_user'

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :message, length: { maximum: 255 }
end
