class Api::V1::UsersController < ApplicationController
  def index
    resources = User.all
    render json: resources, each_serializer: UserSerializer
  end

  def show
    resource = User.find(params[:id])
    render json: resource, serializer: UserSerializer
  end

  def create
    resource = User.new(resource_params)
    if resource.save
      render json: resource, status: :created, serializer: UserSerializer
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    resource = User.find(params[:id])
    if resource.update(resource_params)
      render json: resource, serializer: UserSerializer
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    resource = User.find(params[:id])
    resource.destroy
    head :no_content
  end

  private

  def resource_params
    params.require(:user).permit(:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :views, :role)
  end
end