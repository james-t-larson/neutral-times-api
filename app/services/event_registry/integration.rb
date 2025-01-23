module Services
  module EventRegistry
    class Integration
      include HTTParty
      base_uri "https://eventregistry.org/api/v1"

      def initialize(api_key = nil)
        @api_key = api_key || Rails.application.credentials.dig(:event_registry, :api_key)
      end

      def fetch_articles(external_categories, locations)
        options = {
          body: {
            query: {
              "$query": {
                "$and": [
                  {
                    "$or": external_categories
                  },
                  {
                    "$or": locations
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
  end
end
