class V2::ArticlesController < ::ArticlesController
  def index
    param!(:date, String); validate_date

    category = Category.find_by_id(params[:category_id])
    category_filter = { category_id: category&.id } unless category.nil?
    if params[:date]
      date = DateTime.iso8601(category_filter)
      articles = Article.where(category&.id).published_on(date)
    else
      articles = Article.where(category_filter).last_batch_published
    end

    no_recent_articles = DateTime.now.beginning_of_day > articles.last.created_at
    message = "We are providing old articles as there is something wrong in the background" if no_recent_articles
    code = 1 if no_recent_articles

    generic_render(data: articles, message: message, code: code)
  end
end
