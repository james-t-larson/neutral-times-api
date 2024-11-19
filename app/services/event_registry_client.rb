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
                  { "categoryUri": "dmoz/Society/Politics" },
                  { "categoryUri": "news/Politics" }
                ]
              },
              { "locationUri": "http://en.wikipedia.org/wiki/United_States" },
              {
                "dateStart": Date.today.iso8601(),
                "dateEnd": Date.today.iso8601(),
                "lang": "eng"
              }
            ]
          },
          "$filter": {
            startSourceRankPercentile: 0,
            endSourceRankPercentile: 20,
            isDuplicate: "skipDuplicates",
            minSentiment: -0.2,
            maxSentiment: 0.2
          }
        },
        resultType: "recentActivityArticles",
        recentActivityArticlesSortBy: "socialScore",
        includeArticleDuplicateList: true,
        apiKey: @api_key
      }.to_json,
      headers: { "Content-Type" => "application/json" }
    }

    resp = self.class.post("/article/getArticles", options)
    resp["recentActivityArticles"]["activity"]
  end
end
