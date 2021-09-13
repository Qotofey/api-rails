class V1::Users::TokenController < ApplicationController
  def update

  end

  def destroy

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def token_params
    params.require(:data).permit(%i[refresh_token])
  end
end