class Role < ApplicationRecord
  multi_tenant :tenant

  has_many :users
  has_many :role_permissions, dependent: :destroy
  has_many :permissions, through: :role_permissions, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates_length_of :name, within: 3..50

  def set_permissions(permissions)
    permissions.each do |id|
      permission = Permission.find(id)
      self.permissions << permission
    end
  end
end
