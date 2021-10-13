class V1::Users::Email::ConfirmController < ApplicationController
  def create; end

  private

  def confirmation_params
    params.require(:data).permit(%i[email confirmation_code])
  end
end
