FactoryBot.define do
  factory :role do
    name             { Faker::Name.unique.first_name }
    role_permissions { build_list :role_permission, 1 }
    tenant           { association :tenant }
  end
end
