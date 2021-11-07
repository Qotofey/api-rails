class V1::Users::Email::ConfirmController < ApplicationController
  def create
    form = User::EmailConfirmForm.new(confirmation_params)
    user = form.submit
    if user
      User::ConfirmationService.new(user).call

      render json: Users::ConfirmationSerializer.new(user).as_json, status: :accepted
    else
      render json: form.errors, status: :unprocessable_entity
    end
  end

  private

  def confirmation_params
    params.require(:data).permit(%i[id email code])
  end
end
