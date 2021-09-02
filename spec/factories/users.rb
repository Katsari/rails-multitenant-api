FactoryBot.define do
  factory :user do
    name      { Faker::Lorem.sentence(word_count: 2) }
    username  { Faker::Internet.unique.username }
    email     { Faker::Internet.unique.email }
    password  { Faker::Internet.password }
    role      { association :role }
    tenant    { association :tenant }
  end
end
