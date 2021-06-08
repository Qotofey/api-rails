class V1::Users::SignInController < ApplicationController
  def create; end

  private

  def user_params
    params.require(:user).permit(%i[login password])
  end
end
