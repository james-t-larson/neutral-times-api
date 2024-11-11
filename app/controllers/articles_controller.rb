class ArticlesController < ApplicationController
  def show
    param! :id, Integer

    @article = Article.find(params[:id])
    render json: @article.as_json
  end

  def index
    param! :date, String

    if params[:date]
      validate_date_format
      date = DateTime.iso8601(params[:date])
      articles = Article.published_between(date, date)
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
