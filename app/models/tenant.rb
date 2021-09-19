class Tenant < ApplicationRecord
  multi_tenant :tenant

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }

  has_many :users
  has_many :roles
  has_many :permissions
  has_many :role_permissions
end
