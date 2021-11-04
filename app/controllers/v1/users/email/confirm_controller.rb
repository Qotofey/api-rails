class V1::Users::Email::ConfirmController < ApplicationController
  def create
    form = User::EmailConfirmForm.new(confirmation_params)
    user = form.submit
    if user
      User::ConfirmationService.new(user).call

      render json: { id: user.id, email: user.email, confirmed_at: user.confirmed_at },
             status: :accepted
    else
      render json: form.errors, status: :unprocessable_entity
    end
  end

  private

  def confirmation_params
    params.require(:data).permit(%i[id email code])
  end
end
