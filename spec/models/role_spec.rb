require 'rails_helper'

RSpec.describe Role, type: :model do
  context 'Validations' do
    subject { build(:role) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  it 'has a valid factory' do
    role = FactoryBot.build(:role)
    expect(role).to be_valid
  end
end
