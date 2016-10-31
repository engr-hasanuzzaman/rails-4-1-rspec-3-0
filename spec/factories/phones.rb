FactoryGirl.define do
  factory :phone do
    association :contact
    phone { Faker::PhoneNumber.phone_number }
    phone_type 'home'
  end
end
