class FetchAndSaveArticlesJob
  include Sidekiq::Worker
  sidekiq_options queue: :default

  def perform(group)
    articles = EventRegistry::Integration.new.fetch_articles(group)

    articles.each do |article_data|
      external_article = ExternalArticle.create_or_find_by(article_data)
      GenerateAndSaveArticlesJob.perform_async(external_article.id)
    end
  end
end
