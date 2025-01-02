# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :authenticate_user!, only: [:destroy]
  respond_to :json
  private
  def respond_with(_resource, _opts = {})

    render json: {
      message: 'You are logged in.',
      user: current_user,
    }, status: :ok
  end
  
  def respond_to_on_destroy
      log_out_success
  end
  
  def log_out_success
    reset_session
    render json: { message: 'You are logged out.' }, status: :ok
  end
  
  def log_out_failure
    render json: { message: 'logout failed !!' }, status: :unauthorized
  end

end
