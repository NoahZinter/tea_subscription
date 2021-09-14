FactoryBot.define do
  factory :tea do
    variety { Faker::Tea.variety }
    description { Faker::Emotion.noun }
    temperature { Faker::Number.between(from: 70, to: 110) }
    brew_time { Faker::Number.between(from: 1, to: 6) }
    origin { Faker::Coffee.origin }
  end
end