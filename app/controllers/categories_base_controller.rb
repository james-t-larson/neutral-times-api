class CategoriesBaseController < ApplicationController
  before_action :set_category, only: [ :show ]

  def index
    @categories = Category.all
    render json: @categories
  end

  def show
    render json: @category
  end

  private

  def set_category
    @category = Category.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Category not found" }, status: :not_found
  end

  def category_params
    params.require(:category).permit(:id, :name)
  end
end
