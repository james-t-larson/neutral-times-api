class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    @article = Article.find(params[:id])
    render json: @article.as_json
  end

  def index
    if params[:date]
      return unless validate_date_format
      articles = Article.where(created_at: @date.beginning_of_day..@date.end_of_day)
    else
      articles = Article.published_today
    end

    render json: articles.as_json
  end

  private

  def validate_date_format
    begin
      @date = DateTime.iso8601(params[:date])
      true
    rescue ArgumentError
      render json: {
        error: "Invalid date format. Please provide the date in ISO 8601 format (e.g., '2023-11-07T15:30:00Z' or '2023-11-07') (eg. YYYY-MM-DD)."
      }, status: :unprocessable_entity
      false
    end
  end

  def record_not_found
    render json: { error: "Article not found" }, status: :not_found
  end
end
