FactoryBot.define do
  factory :role_permission do
    tenant     { association :tenant }
    permission { association :permission }
  end
end
