class Permission < ApplicationRecord
  multi_tenant :tenant

  has_many :role_permissions
  has_many :roles, through: :role_permissions

  validates_presence_of :subject_class, :action
end
