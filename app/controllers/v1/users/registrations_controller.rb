class V1::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    return unless params[:email] && params[:password]
    build_resource(sign_up_params)
    resource.save
    if resource.persisted?
      token = WebToken.encode(resource)
      json_response Jwt.new(token: token)
    else
      json_response(resource.errors)
    end
  end

  private

  def sign_up_params
    params.permit(:name, :email, :password, images:[])
  end
end
