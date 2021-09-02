FactoryBot.define do
  factory :tenant do
    name { Faker::Lorem.unique.sentence(word_count: 3) }
  end
end
