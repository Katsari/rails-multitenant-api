require 'rails_helper'

RSpec.describe V1::UserResource, type: :resource do
  before(:each) do
    @tenant = Tenant.find_or_create_by(name: 'Company')
    RLS.set_tenant @tenant
  end

  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'users',
          attributes: {
            username: 'daniela',
            name: 'Daniela Guarecuco',
            password: '123456',
            password_confirmation: '123456',
            email: 'daniela.guarecuco@example.com',
            role_id: create(:role).id,
            tenant_id: @tenant.id
          }
        }
      }
    end

    let(:instance) do
      V1::UserResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { User.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:user) { create(:user, username: 'daniela.guarecuco') }

    let(:payload) do
      {
        data: {
          id: user.id.to_s,
          type: 'users',
          attributes: {
            username: 'daniela',
            name: 'Daniela Guarecuco',
            email: 'daniela.guarecuco@example.com',
          }
        }
      }
    end

    let(:instance) do
      V1::UserResource.find(payload)
    end

    it 'works' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { user.reload.updated_at }
       .and change { user.username }.to('daniela')
       .and change { user.name }.to('Daniela Guarecuco')
       .and change { user.email }.to('daniela.guarecuco@example.com')
    end
  end

  describe 'destroying' do
    let!(:user) { create(:user) }

    let(:instance) do
      V1::UserResource.find(id: user.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { User.count }.by(-1)
    end
  end
end
