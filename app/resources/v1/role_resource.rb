class V1::RoleResource < V1::APIResource
  attribute :tenant_id, :integer_id, only: [:writable]
  attribute :name, :string

  has_many :users
  many_to_many :permissions, foreign_key: { permissions_roles: :permission_id }, link: false
end
