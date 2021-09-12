class V1::Users::SignUpController < ApplicationController
  def create

  end

  private

  def sign_up_params
    params.require(:data).permit(%i[email password])
  end
end