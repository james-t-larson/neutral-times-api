class FetchAndSaveArticlesJob < ApplicationJob
  queue_as :default

  def perform(group)
    articles = EventRegistry::Integration.new.fetch_articles(group)
    external_articles = ExternalArticle.find_or_create_by(articles)

    GenerateAndSaveArticlesJob.perform_later(external_articles)
  end
end
