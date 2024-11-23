class V2::ArticlesController < ::ArticlesController
  def index
    param!(:date, String); validate_date

    if params[:date]
      date = DateTime.iso8601(params[:date])
      articles = Article.published_on(date)
    else
      articles = Article.last_batch_published
    end

    message = "We are providing old articles as there is something wrong in the background" if  Date.today > articles.last.created_at

    generic_render(articles, message)
  end
end
