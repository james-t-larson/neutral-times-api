class ArticlesController < ApplicationController
  before_action :validate_date_format, only: :index

  def show
    param! :id, Integer

    @article = Article.find(params[:id])
    render json: @article.as_json
  end

  def index
    param! :date, String

    if params[:date]
      date = DateTime.iso8601(params[:date])
      articles = Article.where(created_at: date.beginning_of_day..date.end_of_day)
    else
      articles = Article.published_today
    end

    render json: articles.as_json
  end

  private

  def validate_date_format
    begin
      DateTime.iso8601(params[:date])
    rescue ArgumentError
      raise RailsParam::InvalidParameterError.new("Parameter date is invalid. ISO-8601 is required")
    end
  end
end
