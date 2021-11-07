class V1::Users::Password::RecoverController < ApplicationController
  def create
    form = User::RecoverForm.new(recovery_params)
    user = form.submit
    if user
      User::RecoveryService.new(user, recovery_params[:password]).call

      render json: Users::RecoverySerializer.new(user).as_json, status: :accepted
    else
      render json: form.errors, status: :unprocessable_entity
    end
  end

  private

  def recovery_params
    params.require(:data).permit(%i[id email code password password_confirmation])
  end
end
