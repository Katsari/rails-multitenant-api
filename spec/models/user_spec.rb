require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validations' do
    subject { build(:user) }

    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
  end

  it 'has a valid factory' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it 'is invalid without a email' do
    user = FactoryBot.build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid without an username' do
    user = FactoryBot.build(:user, username: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid without a name' do
    user = FactoryBot.build(:user, name: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid without a password' do
    user = FactoryBot.build(:user, password: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid with a duplicate username' do
    FactoryBot.create(:user, username: 'John')
    user = FactoryBot.build(:user, username: 'John')

    user.valid?
    expect(user.errors[:username].size).to eq(1)
  end

  it 'is invalid with a duplicate email' do
    FactoryBot.create(:user, email: 'test@example.com')
    user = FactoryBot.build(:user, email: 'test@example.com')

    expect(user).not_to be_valid
  end
end
