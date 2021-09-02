class RolePermission < ApplicationRecord
  belongs_to :tenant
  belongs_to :role
  belongs_to :permission
end
