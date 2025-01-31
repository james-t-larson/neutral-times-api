class FetchAndSaveArticlesJob < ApplicationJob
  queue_as :default

  def perform(group)
    articles = EventRegistry::Integration.new.fetch_articles(group)
    ExternalArticle.find_or_create_by(articles)
  end
end
