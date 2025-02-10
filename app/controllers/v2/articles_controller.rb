class V2::ArticlesController < ::ArticlesController
  before_action :set_category, if: -> { params[:category_id].present? }, only: [ :index ]

  def show
    param!(:id, Integer)

    @article = Article.find(params[:id])
    render json: @article.as_json
    generic_render(data: @article)
  end

  def index
    param!(:date, String); validate_date

    if params[:date]
      date = DateTime.iso8601(params[:date])
      @articles ||= Article.by_category(@category).published_on(date)
    else
      @articles ||= Article.by_category(@category).last_batch_published
    end

    no_recent_articles = @articles.any? ? (DateTime.now.beginning_of_day > @articles.last.created_at) : true
    message = "We are providing old articles as there is something wrong in the background" if no_recent_articles
    code = 1 if no_recent_articles

    if !@category.nil?
      generic_render(data: @articles, message: message, code: code, category: @category.name)
    else
      generic_render(data: @articles, message: message, code: code)
    end
  end

  private

  def set_category
    @category ||= Category.find(params[:category_id])
  end
end
