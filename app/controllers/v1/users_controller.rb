class V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    collection = ::Users::IndexPresenter.new(params).users

    render_collection collection, each_serializer: ::Users::IndexSerializer
  end

  def show
    render json: ::Users::ShowSerializer.new(@user).as_json, status: :ok
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: ::Users::CreateSerializer.new(@user).as_json, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: ::Users::UpdateSerializer.new(@user).as_json
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    User::SoftDeletionService.new(@user).call
  end

  private

  def set_user
    @user = User.find(params[:id])

    authorize @user
  end

  def user_params
    params.require(:user).permit(*allowed_params)
  end

  def allowed_params
    %i[promo first_name last_name middle_name email phone birth_date gender confirmed deleted
       password password_confirmation]
  end
end
