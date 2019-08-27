FactoryGirl.define do
  factory :customer do
    name { Faker::Name.name }
    wechat { Faker::Number.number(digits: 8) }
  end
end
