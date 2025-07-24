class Api::V1::CommentsController < ApplicationController
  def index
    resources = Comment.all
    render json: resources, each_serializer: CommentSerializer
  end

  def show
    resource = Comment.find(params[:id])
    render json: resource, serializer: CommentSerializer
  end

  def create
    resource = Comment.new(resource_params)
    if resource.save
      render json: resource, status: :created, serializer: CommentSerializer
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    resource = Comment.find(params[:id])
    if resource.update(resource_params)
      render json: resource, serializer: CommentSerializer
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    resource = Comment.find(params[:id])
    resource.destroy
    head :no_content
  end

  private

  def resource_params
    params.require(:comment).permit(:post_id, :user_id)
  end
end