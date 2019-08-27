class Customer < ApplicationRecord

  has_many :addresses, dependent: :destroy

  validates_presence_of :name, :wechat
end
