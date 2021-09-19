class V1::UserResource < V1::APIResource
  attribute :tenant_id, :integer_id, only: [:writable]
  attribute :uid, :string
  attribute :email, :string
  attribute :username, :string
  attribute :name, :string
  attribute :disabled, :boolean
  attribute :password, :string, only: [:writable]
  attribute :password_confirmation, :string, only: [:writable]
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
  attribute :role_id, :integer

  belongs_to :role

  filter :role_id, :integer
end
