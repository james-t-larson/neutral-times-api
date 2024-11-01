class ArticleGenerationService
  def initialize
    @aggregator_client ||= NewsApiClient.new
    @generator_client ||= OpenaiClient.new
  end

  def generate_and_save_article
    headline = fetch_headline
    generated_content = generate_article_content(headline)
    save_article(headline, generated_content)
  end

  private

  def fetch_headline
    top_headlines = @aggregator_client.fetch_top_headlines
    top_headlines["articles"].first["title"]
  end

  def generate_article_content(headline)
    @generator_client.generate_article(headline)
  end

  def save_article(title, content)
    content
    # Article.create!(
    #   title: title,
    #   content: content,
    # )
  end
end
