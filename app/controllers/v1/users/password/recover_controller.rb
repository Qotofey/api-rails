class V1::Users::Password::RecoverController < ApplicationController
  def create
    form = User::RecoverForm.new(recovery_params)
    user = form.submit
    if user
      # User::ConfirmationService.new(user).call
      #
      # render json: { id: user.id, email: user.email, confirmed_at: user.confirmed_at },
      #        status: :accepted
      render_ok
    else
      render json: form.errors, status: :unprocessable_entity
    end
  end

  private

  def recovery_params
    params.require(:data).permit(%i[id email code password password_confirmation])
  end
end
