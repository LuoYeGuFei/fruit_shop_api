class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :wechat, :created_by, :updated_by

  has_many :addresses
  belongs_to :user
end
