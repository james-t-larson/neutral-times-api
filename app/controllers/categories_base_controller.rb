class CategoriesBaseController < ApplicationController
  before_action :set_category, only: [ :show ]

  def index
    @categories = Category.all.
    generic_render(data: @categories).order(:position)
  end

  def show
    generic_render(data: @category)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:id, :name)
  end
end
