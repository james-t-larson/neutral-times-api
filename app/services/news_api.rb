class NewsApi
  include HTTParty
  base_uri "https://newsapi.org/v2"

  def initialize(api_key)
    @api_key = api_key || Rails.application.credentials.dig(:news_api, :api_key)
  end

  def fetch_top_headlines(country: "us", category: nil)
    options = {
      query: {
        country: country,
        category: category,
        apiKey: @api_key
      }
    }

    self.class.get("/top-headlines", options)
  end

  def fetch_everything(query)
    options = {
      query: {
        q: query,
        apiKey: @api_key
      }
    }

    self.class.get("/everything", options)
  end
end
