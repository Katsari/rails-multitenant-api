require 'rails_helper'

RSpec.describe Tenant, type: :model do
  context 'Validations' do
    subject { build(:tenant) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  it 'has a valid factory' do
    tenant = FactoryBot.build(:tenant)
    expect(tenant).to be_valid
  end

  it 'is invalid without a name' do
    tenant = FactoryBot.build(:tenant, name: nil)

    tenant.valid?
    expect(tenant.errors[:name].size).to eq(1)
  end
end
