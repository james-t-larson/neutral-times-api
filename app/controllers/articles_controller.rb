class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    @article = Article.find(params[:id])
    render json: @article.as_json
  end

  def index
    articles = Article.all
    render json: articles.as_json
  end

  private

  def record_not_found
    render json: { error: "Article not found" }, status: :not_found
  end
end
