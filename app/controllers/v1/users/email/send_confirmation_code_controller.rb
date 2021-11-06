class V1::Users::Email::SendConfirmationCodeController < ApplicationController
  def create
    # form =
  end

  private

  def confirmation_params
    params.require(:data).permit(%i[email])
  end
end
