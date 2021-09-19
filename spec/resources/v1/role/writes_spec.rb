require 'rails_helper'

RSpec.describe V1::RoleResource, type: :resource do
  before(:each) do
    @tenant = Tenant.find_or_create_by(name: 'Company')
    RLS.set_tenant @tenant
  end

  describe 'creating' do
    let(:permission) { create(:permission) }

    let(:payload) do
      {
        data: {
          type: 'roles',
          attributes: {
            name: 'Supervisor',
            tenant_id: @tenant.id
          },
          relationships: {
            permissions: {
              data: [
                {
                  type: 'permissions',
                  id: permission.id.to_s,
                  method: 'update'
                }
              ]
            }
          }
        }
      }
    end

    let(:instance) do
      V1::RoleResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Role.count }.by(1)
      role = Role.last
      expect(role.name).to eq('Supervisor')
      expect(role.permissions.map(&:id)).to eq([permission.id])
    end
  end

  describe 'updating' do
    let!(:role) { create(:role, name: 'Supervisor') }

    let(:payload) do
      {
        data: {
          id: role.id.to_s,
          type: 'roles',
          attributes: {
            name: 'Warehouse Manager'
          }
        }
      }
    end

    let(:instance) do
      V1::RoleResource.find(payload)
    end

    it 'works' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { role.reload.updated_at }
      .and change { role.name }.to('Warehouse Manager')
    end
  end

  describe 'destroying' do
    let!(:role) { create(:role) }

    let(:instance) do
      V1::RoleResource.find(id: role.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Role.count }.by(-1)
    end
  end
end
