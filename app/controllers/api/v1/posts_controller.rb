class Api::V1::PostsController < ApplicationController
  def index
    resources = Post.all
    render json: resources, each_serializer: PostSerializer
  end

  def show
    resource = Post.find(params[:id])
    render json: resource, serializer: PostSerializer
  end

  def create
    resource = Post.new(resource_params)
    if resource.save
      render json: resource, status: :created, serializer: PostSerializer
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    resource = Post.find(params[:id])
    if resource.update(resource_params)
      render json: resource, serializer: PostSerializer
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    resource = Post.find(params[:id])
    resource.destroy
    head :no_content
  end

  private

  def resource_params
    params.require(:post).permit(:title, :body, :views, :user_id, :published_at)
  end
end