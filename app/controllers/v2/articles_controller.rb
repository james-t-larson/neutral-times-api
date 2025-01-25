class V2::ArticlesController < ::ArticlesController
  before_action :set_category_filter, if: -> { params[:category_id].present? }, only: [ :index ]

  def index
    param!(:date, String); validate_date

    if params[:date]
      date = DateTime.iso8601(params[:date])
      @articles ||= Article.where(@category_filter).published_on(date)
    else
      @articles ||= Article.where(@category_filter).last_batch_published
    end

    no_recent_articles = DateTime.now.beginning_of_day > @articles.last.created_at
    message = "We are providing old articles as there is something wrong in the background" if no_recent_articles
    code = 1 if no_recent_articles

    if !@category.nil?
      generic_render(data: @articles, message: message, code: code, category: @category.name)
    else
      generic_render(data: @articles, message: message, code: code)
    end
  end

  private

  def set_category_filter
    @category ||= Category.find(params[:category_id])
    @category_filter ||= { category_id: @category&.id } unless @category.nil?
  end
end
