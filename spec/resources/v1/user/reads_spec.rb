require 'rails_helper'

RSpec.describe V1::UserResource, type: :resource do
  describe 'serialization' do
    let!(:user) { create(:user, attrs) }

    let(:attrs) do
      {
        username: 'jane.doe',
        name: 'Jane Doe',
        email: 'test@example.com'
      }
    end

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(user.id)
      expect(data.jsonapi_type).to eq('users')
      expect(data.username).to eq('jane.doe')
      expect(data.name).to eq('Jane Doe')
      expect(data.email).to eq('test@example.com')
      expect(data.role_id).to eq(user.role_id)
    end
  end

  describe 'filtering' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: user2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([user2.id])
      end
    end

    context 'by role' do
      before do
        params[:filter] = { role_id: { eq: user2.role_id } }
      end

      it 'works' do
        render
        expect(d.map(&:role_id)).to eq([user2.role_id])
      end
    end

    context 'by username' do
      before do
        params[:filter] = { username: { eq: user2.username } }
      end

      it 'works' do
        render
        expect(d.map(&:username)).to eq([user2.username])
      end
    end

    context 'by name' do
      before do
        params[:filter] = { name: { eq: user2.name } }
      end

      it 'works' do
        render
        expect(d.map(&:name)).to eq([user2.name])
      end
    end

    context 'by email' do
      before do
        params[:filter] = { email: { eq: user2.email } }
      end

      it 'works' do
        render
        expect(d.map(&:email)).to eq([user2.email])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:user1) { create(:user, id: 1) }
      let!(:user2) { create(:user, id: 2) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            user1.id,
            user2.id
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
            user2.id,
            user1.id
          ])
        end
      end
    end

    describe 'by role' do
      let!(:role1) { create(:role, name: 'Warehouse Manager') }
      let!(:role2) { create(:role, name: 'Supervisor') }
      let!(:user1) { create(:user, role: role1) }
      let!(:user2) { create(:user, role: role2) }

      context 'when ascending' do
        before do
          params[:sort] = 'role_id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            user1.id,
            user2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-role_id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            user2.id,
            user1.id
          ])
        end
      end
    end

    describe 'by username' do
      let!(:user1) { create(:user, username: 'isabel') }
      let!(:user2) { create(:user, username: 'jane') }

      context 'when ascending' do
        before do
          params[:sort] = 'username'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            user1.id,
            user2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-username'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            user2.id,
            user1.id
          ])
        end
      end
    end

    describe 'by name' do
      let!(:user1) { create(:user, name: 'Isabel') }
      let!(:user2) { create(:user, name: 'Jane') }

      context 'when ascending' do
        before do
          params[:sort] = 'name'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            user1.id,
            user2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-name'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            user2.id,
            user1.id
          ])
        end
      end
    end

    describe 'by email' do
      let!(:user1) { create(:user, email: 'isabel.lewis@example.com.ve') }
      let!(:user2) { create(:user, email: 'jane.watson@example.com.ve') }

      context 'when ascending' do
        before do
          params[:sort] = 'email'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            user1.id,
            user2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-email'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            user2.id,
            user1.id
          ])
        end
      end
    end
  end
end
