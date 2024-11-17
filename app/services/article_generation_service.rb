class ArticleGenerationService
  def initialize
    @aggregator_client ||= EventRegistryClient.new
    @generator_client ||= OpenaiClient.new
  end

  def generate_and_save_articles
    articles = fetch_articles()

    articles.each do |article|
      generated_content = generate_article(article.to_s)
      save_article(generated_content)
    end
  end

  private

  def fetch_articles
    @aggregator_client.fetch_articles
  end

  def generate_article(article)
    @generator_client.generate_article(article)
  end

  def save_article(content)
    Article.create!(content[:article])
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Failed to save article: #{e.message}"
  end
end
