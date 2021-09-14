class V1::Users::SignUpController < ApplicationController
  def create
    user = User.new(sign_up_params)
    if user.save
      render json: { status: :ok }
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:data).permit(%i[email password password_confirmation])
  end
end
