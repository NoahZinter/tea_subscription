FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    address { Faker::Address.full_address }
    email { Faker::Internet.email }
    google_token { Faker::Lorem.characters(number:10) }
    google_refresh_token { Faker::Lorem.characters(number:10) }
  end
end

