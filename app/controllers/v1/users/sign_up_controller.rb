class V1::Users::SignUpController < ApplicationController
  def create
    user = User.new(registration_params) # TODO: заменить на Service/Form Object

    if user.save
      render json: { status: :created }
    else
      render json: user.errors, status: :forbidden
    end
  end

  private

  def registration_params
    params.require(:data).permit(%i[email promo password password_confirmation])
  end
end
