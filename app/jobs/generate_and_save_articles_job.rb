class GenerateAndSaveArticlesJob < ApplicationJob
  queue_as :default
  @@mutex = Mutex.new

  def perform(external_article)
    @@mutex.synchronize do
      puts "[#{Time.now}]: Starting GenerateAndSaveArticlesJob"
      return unless Article.find_by(external_article_id: external_article.id).nil?
      content = Openai::Integration.new.generate_article(external_article)[:article]
      Article.find_or_create_by({
        title: content[:title],
        summary: content[:summary],
        content: content[:content],
        external_article_id: external_article.id,
        category_id: external_article.category_id,
        image: external_article.image,
        event_id: external_article.event_id,
        location: external_article.location,
        sources: external_article.source,
        relevance: external_article.relevance
      })
      puts "[#{Time.now}]: Completed GenerateAndSaveArticlesJob"
    end
  end
end
