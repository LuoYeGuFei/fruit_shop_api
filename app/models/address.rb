class Address < ApplicationRecord

  belongs_to :customer

  validates_presence_of :receiver, :tel, :addr
end
