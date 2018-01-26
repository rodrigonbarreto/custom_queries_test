FactoryBot.define do
  factory :person do
    location
    name Faker::Name.name
    role
    salary 0

  end
end