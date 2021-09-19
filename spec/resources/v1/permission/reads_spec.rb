require 'rails_helper'

RSpec.describe V1::PermissionResource, type: :resource do
  describe 'serialization' do
    let!(:permission) { create(:permission) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(permission.id)
      expect(data.jsonapi_type).to eq('permissions')
    end
  end

  describe 'filtering' do
    let!(:permission1) { create(:permission) }
    let!(:permission2) { create(:permission) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: permission2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([permission2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:permission1) { create(:permission) }
      let!(:permission2) { create(:permission) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            permission1.id,
            permission2.id
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
            permission2.id,
            permission1.id
          ])
        end
      end
    end
  end
end
