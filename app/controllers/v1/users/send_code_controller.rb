class V1::Users::SendCodeController < ApplicationController
  before_action :set_user, only: %i[update]

  def create; end

  def update; end

  private

  def set_user
    @user = User.find_by!(email: params[:email])
  end
end
