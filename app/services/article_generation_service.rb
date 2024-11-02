class ArticleGenerationService
  def initialize
    @aggregator_client ||= NewsApiClient.new
    @generator_client ||= OpenaiClient.new
  end

  def generate_and_save_articles(count = 5)
    headlines = fetch_headlines(count)

    headlines.each do |headline|
      generated_content = generate_article_content(headline)
      save_article(generated_content)
    end
  end

  private

  def fetch_headlines(count)
    top_headlines = @aggregator_client.fetch_top_headlines(category: "business")
    top_headlines["articles"].first(count).map { |article| article["title"] }
  end

  def generate_article_content(headline)
    @generator_client.generate_article(headline)
  end

  def save_article(content)
    Article.create!(content[:article])
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Failed to save article: #{e.message}"
  end
end
