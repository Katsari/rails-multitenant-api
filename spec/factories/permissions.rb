FactoryBot.define do
  factory :permission do
    subject_class    { 'all' }
    action           { 'manage' }
    action_name      { 'All' }
    subject_name     { 'All' }
    subject_group    { nil }
    tenant           { association :tenant }
  end
end
