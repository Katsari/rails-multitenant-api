class API::V1::RolesController < APIController
  def index
    roles = V1::RoleResource.all(params)
    respond_with(roles)
  end

  def show
    role = V1::RoleResource.find(params)
    respond_with(role)
  end

  def create
    role = V1::RoleResource.build(params)
    if role.save
      render jsonapi: role, status: 201
    else
      render jsonapi_errors: role
    end
  end

  def update
    role = V1::RoleResource.find(params)
    if role.update_attributes
      render jsonapi: role
    else
      render jsonapi_errors: role
    end
  end

  def destroy
    role = V1::RoleResource.find(params)
    if role.data.users.any?
      role.errors.add(:base, 'This role has associated users')
      render jsonapi_errors: role
    else
      if role.destroy
        render jsonapi: { meta: {} }, status: 200
      else
        render jsonapi_errors: role
      end
    end
  end
end
