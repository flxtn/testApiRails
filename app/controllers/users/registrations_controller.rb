# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json


  def create
    build_resource(sign_up_params)

    if resource.save
      render json: { message: "User registered successfully." }, status: :created
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sign_up(resource_name, resource)
  end

  def respond_with(resource, options={})
    register_success && return if resource.persisted?
    register_failed
  end
  
  def register_success 
    render json:{
        status:{code: 200, message:"Signed Up Successfully", data: resource}
      }, status: :ok
  end
  
  def register_failed 
    render json:{
        status:{message:"User Can't be Created !!", errors: resource.errors.full_messages}
      }, status: :unprocessable_entity
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :role)
  end
end
