FactoryGirl.define do
  factory :contact do
    firstname 'hasanuzzaman'
    lastname 'sumon'
    sequence(:email) { |n| "dev_#{n}@example.com" }
  end
end
