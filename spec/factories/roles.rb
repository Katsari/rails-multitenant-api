FactoryBot.define do
  factory :role do
    name             { Faker::Name.unique.name_with_middle }
    permissions      { [association(:permission)] }
    tenant           { association :tenant }
  end
end
