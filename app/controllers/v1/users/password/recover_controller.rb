class V1::Users::Password::RecoverController < ApplicationController
  def create; end

  private

  def recovery_params
    params.require(:data).permit(%i[email code password password_confirmation])
  end
end
