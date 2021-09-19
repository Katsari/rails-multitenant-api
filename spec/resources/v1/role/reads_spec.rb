require 'rails_helper'

RSpec.describe V1::RoleResource, type: :resource do
  describe 'serialization' do
    let!(:role) { create(:role) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(role.id)
      expect(data.jsonapi_type).to eq('roles')
    end
  end

  describe 'filtering' do
    let!(:role1) { create(:role) }
    let!(:role2) { create(:role) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: role2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([role2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:role1) { create(:role) }
      let!(:role2) { create(:role) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            role1.id,
            role2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            role2.id,
            role1.id
          ])
        end
      end
    end
  end
end
