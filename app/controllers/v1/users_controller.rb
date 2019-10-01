class V1::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update]
  before_action :set_user, only: [:show, :update]

  def show
    return render_not_found! unless @user

    if current_user.id == @user.id
      json_response(@user)
    else
      render_unauthorized!
    end
  end

  def update
    return render_not_found! unless @user

    update = @user.update!(permited_params)
    @user.images.attach(params.require(:images))  if params[:images].present?
    if update
      json_response(
        @user,
        meta: {
          jwt: Jwt.new(token: WebToken.encode(@user)),
        }
      )
    else
      render_unprocessable_entity!(update.errors)
    end
  end

  private

  def permited_params
    params.permit(
      :name,
      :email,
      :password,
      images: []
    )
  end

  def set_user
    @user = User.where(id: params[:id]).first
  end

end
