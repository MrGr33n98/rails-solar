class Api::V1::ProductsController < ApplicationController
  def index
    resources = Product.all
    render json: resources, each_serializer: ProductSerializer
  end

  def show
    resource = Product.find(params[:id])
    render json: resource, serializer: ProductSerializer
  end

  def create
    resource = Product.new(resource_params)
    if resource.save
      render json: resource, status: :created, serializer: ProductSerializer
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    resource = Product.find(params[:id])
    if resource.update(resource_params)
      render json: resource, serializer: ProductSerializer
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    resource = Product.find(params[:id])
    resource.destroy
    head :no_content
  end

  private

  def resource_params
    params.require(:product).permit(:name, :seo_url, :seo_title, :status, :kind, :premium_until, :source, :country, :name_translations, :description_translations)
  end
end