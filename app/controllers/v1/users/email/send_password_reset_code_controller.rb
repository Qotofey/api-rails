class V1::Users::Email::SendPasswordResetCodeController < ApplicationController
  def create
    form = User::IdEmailForm.new(recovery_params)
    user = form.submit
    if user
      PasswordResetMailer.with(user: user).make.deliver_later
      render_ok
    else
      render json: form.errors, status: :unprocessable_entity
    end
  end

  private

  def recovery_params
    params.require(:data).permit(%i[id email])
  end
end
