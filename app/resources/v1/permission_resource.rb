class V1::PermissionResource < V1::APIResource
  attribute :tenant_id, :integer_id, only: [:writable]
  attribute :subject_class, :string
  attribute :action, :string
  attribute :action_name, :string
  attribute :subject_name, :string
  attribute :subject_group, :string

  many_to_many :roles, foreign_key: { permissions_roles: :role_id }
end
