class V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.all

    render json: @users
  end

  def show
    render json: ::Users::ShowSerializer.new(@user).as_json
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(*allowed_params)
  end

  def allowed_params
    %i[login first_name last_name middle_name email phone password_digest birth_date gender
       confirmed_at deleted_at
       created_by_user_id updated_by_user_id deleted_by_user_id confirmed_by_user_id]
  end
end
