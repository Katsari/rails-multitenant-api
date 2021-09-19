class API::V1::UsersController < APIController
  def index
    users = V1::UserResource.all(params, User.includes(:role).where(disabled: false))
    respond_with(users)
  end

  def show
    user = V1::UserResource.find(params)
    respond_with(user)
  end

  def create
    user = V1::UserResource.build(params)

    if user.save
      render jsonapi: user, status: 201
    else
      render jsonapi_errors: user
    end
  end

  def update
    user = V1::UserResource.find(params)

    if user.update_attributes
      render jsonapi: user
    else
      render jsonapi_errors: user
    end
  end

  def destroy
    user = V1::UserResource.find(params)

    if user.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: user
    end
  end
end
