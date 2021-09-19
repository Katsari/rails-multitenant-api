require 'rails_helper'

RSpec.describe V1::PermissionResource, type: :resource do
  before(:each) do
    @tenant = Tenant.find_or_create_by(name: 'Company')
    RLS.set_tenant @tenant
  end

  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'permissions',
          attributes: {
            subject_class: 'User',
            action: 'manage',
            action_name: 'All',
            subject_name: 'Users',
            tenant_id: @tenant.id
          }
        }
      }
    end

    let(:instance) do
      V1::PermissionResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Permission.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:permission) { create(:permission) }

    let(:payload) do
      {
        data: {
          id: permission.id.to_s,
          type: 'permissions',
          attributes: {
            subject_class: 'User',
            action: 'manage',
            action_name: 'All',
            subject_name: 'Users',
            subject_group: 'Settings'
          }
        }
      }
    end

    let(:instance) do
      V1::PermissionResource.find(payload)
    end

    it 'works' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { permission.reload.updated_at }
      .and change { permission.subject_class }.to('User')
      .and change { permission.subject_name }.to('Users')
      .and change { permission.subject_group }.to('Settings')
    end
  end

  describe 'destroying' do
    let!(:permission) { create(:permission) }

    let(:instance) do
      V1::PermissionResource.find(id: permission.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Permission.count }.by(-1)
    end
  end
end
