class V1::Users::SignInController < ApplicationController
  def create
    form = User::SignInForm.new(authentication_params)
    user = form.submit
    if user
      jwt = User::JwtCreationService.new(user).call
      # byebug
      render json: ::JwtSerializer.new(jwt).as_json
    else
      render json: form.errors, status: :unprocessable_entity
    end
  end

  private

  def authentication_params
    params.require(:data).permit(%i[email password])
  end
end
