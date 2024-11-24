class V2::ArticlesController < ::ArticlesController
  def index
    param!(:date, String); validate_date

    if params[:date]
      date = DateTime.iso8601(params[:date])
      articles = Article.published_on(date)
    else
      articles = Article.last_batch_published
    end

    no_recent_articles = DateTime.now.beginning_of_day > articles.last.created_at
    message = "We are providing old articles as there is something wrong in the background" if no_recent_articles
    code = 1 if no_recent_articles

    generic_render(articles, message, code)
  end
end
