class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, only: [:index]
  before_action :set_user, only: [:current, :update]

  def update
    if current_user.admin? || @user == current_user
      if @user.update(user_params)
        render json: @user, status: :ok
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Access denied" }, status: :forbidden
    end
  end

  def current
    render json: @user, status: :ok
  end

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  private

  def set_user
    if current_user.admin? && params[:id].present?
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  end
  def authorize_admin!
    unless current_user&.admin?
      render json: { error: "Access denied" }, status: :forbidden
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role, :password, :password_confirmation)
  end
end
