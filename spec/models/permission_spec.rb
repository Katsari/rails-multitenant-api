require 'rails_helper'

RSpec.describe Permission, type: :model do
  context 'Associations' do
    it { should belong_to(:tenant) }
    it { should have_many(:role_permissions) }
    it { should have_many(:roles).through(:role_permissions) }
  end

  context 'Validations' do
    subject { build(:permission) }

    it { should validate_presence_of(:subject_class) }
    it { should validate_presence_of(:action) }
  end

  it 'has a valid factory' do
    permission = FactoryBot.build(:permission)
    expect(permission).to be_valid
  end
end
