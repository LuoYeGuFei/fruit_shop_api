FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email 'lyz@qq.com'
    password '123456'
  end
end
