FactoryGirl.define do
  factory :address do
    receiver { Faker::Name.name }
    tel { Faker::PhoneNumber.cell_phone }
    addr { Faker::Address.full_address }
  end
end
