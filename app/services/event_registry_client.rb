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
                  # categories will go here
                ]
              },
              {
                "$or": [
                  {
                    "locationUri": "http://en.wikipedia.org/wiki/Oregon"
                  },
                  {
                    "locationUri": "http://en.wikipedia.org/wiki/British_Columbia"
                  },
                  {
                    "locationUri": "http://en.wikipedia.org/wiki/Colorado"
                  },
                  {
                    "locationUri": "http://en.wikipedia.org/wiki/Canada"
                  },
                  {
                    "locationUri": "http://en.wikipedia.org/wiki/United_States"
                  }
            ]
          },
          {
            "dateStart": Date.today.iso8601(),
            "dateEnd": Date.today.iso8601(),
            "lang": "eng"
          }
            ]
        },
        "$filter": {
          "hasEvent": "skipArticlesWithoutEvent",
          "startSourceRankPercentile": 0,
          "endSourceRankPercentile": 30,
          "minSentiment": -0.2,
          "maxSentiment": 0.4,
          "isDuplicate": "skipDuplicates"
        }
      },
      "resultType": "articles",
      "articlesSortBy": "socialScore",
      "includeArticleSocialScore": true,
      "includeArticleCategories": true,
      "includeArticleLocation": true,
      "includeArticleImage": true,
      "includeConceptDescription": true,
      "includeSourceRanking": true,
      apiKey: @api_key
    }.to_json,
    headers: { "Content-Type" => "application/json" }
}

    resp = self.class.post("/article/getArticles", options)
    resp.dig("articles", "results")&.first(10)
  end
end
