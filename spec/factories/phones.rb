FactoryGirl.define do
  factory :phone do
    association :contact
    phone '1234'
    phone_type 'home'
  end
end
