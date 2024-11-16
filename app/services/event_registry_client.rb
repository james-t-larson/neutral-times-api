class EventRegistryClient
  include HTTParty
  base_uri "https://eventregistry.org/api/v1"

  def initialize(api_key = nil)
    @api_key = api_key || Rails.application.credentials.dig(:event_registry, :api_key)
  end

  def fetch_articles
    options = {
      body: {
        query: {
          "$query": {
            "$and": [
              {
                "$or": [
                  { "categoryUri": "dmoz/Business" },
                  { "categoryUri": "news/Politics" }
                ]
              },
              { "locationUri": "http://en.wikipedia.org/wiki/United_States" },
              { "lang": "eng" }
            ]
          },
          "$filter": {
            startSourceRankPercentile: 0,
            endSourceRankPercentile: 10,
            isDuplicate: "skipDuplicates"
          }
        },
        recentActivityArticlesMaxArticleCount: 10,
        recentActivityArticlesUpdatesAfterMinsAgo: 720,
        apiKey: @api_key
      }.to_json,
      headers: { "Content-Type" => "application/json" }
    }

    resp = self.class.post("/minuteStreamArticles", options)
    resp["recentActivityArticles"]["activity"]
  end
end
