class V1::Users::Email::SendRecoveryCodeController < ApplicationController
  def create; end

  private

  def recovery_params
    params.require(:data).permit(%i[email])
  end
end
