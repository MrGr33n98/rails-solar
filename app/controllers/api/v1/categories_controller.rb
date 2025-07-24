class Api::V1::CategoriesController < ApplicationController
  def index
    resources = Category.all
    render json: resources, each_serializer: CategorySerializer
  end

  def show
    resource = Category.find(params[:id])
    render json: resource, serializer: CategorySerializer
  end

  def create
    resource = Category.new(resource_params)
    if resource.save
      render json: resource, status: :created, serializer: CategorySerializer
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    resource = Category.find(params[:id])
    if resource.update(resource_params)
      render json: resource, serializer: CategorySerializer
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    resource = Category.find(params[:id])
    resource.destroy
    head :no_content
  end

  private

  def resource_params
    params.require(:category).permit(:name, :slug, :description, :parent_id, :active, :seo_title, :seo_description, :seo_keywords, :canonical_url, :meta_robots, :h1, :intro_text, :schema_markup, :name_translations, :description_translations)
  end
end