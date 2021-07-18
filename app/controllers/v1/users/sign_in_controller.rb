class V1::Users::SignInController < ApplicationController
  def create
    validator = AuthByEmailValidator.new(sign_in_params)
    user = validator.call
    if user
      render json: ::JwtSerializer.new(user).as_json
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def sign_in_params
    params.require(:sign_in).permit(%i[email password])
  end
end
