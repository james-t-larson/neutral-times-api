class ArticlesController < ApplicationController
  def show
    param!(:id, Integer)

    @article = Article.find(params[:id])
    render json: @article.as_json
  end

  def index
    param!(:date, String); validate_date

    if params[:date]
      date = DateTime.iso8601(params[:date])
      articles = Article.published_on(date)
    else
      articles = Article.last_batch_published
    end

    render json: articles.as_json
  end

  private

  def validate_date
    return if !params[:date]

    begin
      DateTime.iso8601(params[:date])
      if Time.parse(params[:date]) > Time.now
        raise RailsParam::InvalidParameterError.new("Date cannot be in the future")
      end
    rescue ArgumentError
      raise RailsParam::InvalidParameterError.new("Parameter date is invalid. ISO-8601 is required")
    end
  end
end
