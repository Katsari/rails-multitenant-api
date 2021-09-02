class Permission < ApplicationRecord
  belongs_to :tenant
  has_many :role_permissions
  has_many :roles, through: :role_permissions
end
