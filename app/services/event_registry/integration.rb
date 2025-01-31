module EventRegistry
  class Integration
    include HTTParty
    base_uri "https://eventregistry.org/api/v1"

    def initialize(api_key = nil)
      @api_key = api_key || Rails.application.credentials.dig(:event_registry, :api_key)
    end

    def fetch_articles(group = {})
      options = {
        body: {
          query: {
            "$query": {
              "$and": [
                {
                  "$or": group[:external_categories]
                },
                {
                  "$or": group[:locations]
                },
                {
                  "dateStart": Date.yesterday.iso8601(),
                  "dateEnd": Date.yesterday.iso8601(),
                  "lang": "eng"
                }
              ]
            },
            "$filter": {
              "hasEvent": "skipArticlesWithoutEvent",
              "startSourceRankPercentile": 0,
              "endSourceRankPercentile": 40,
              "minSentiment": -0.3,
              "maxSentiment": 1,
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
      articles = resp.dig("articles", "results")

      @external_articles = ExternalArticle.pluck(:title).each_with_object({}) do |title, hash|
        hash[title] = true
      end

      articles.filter_map do |article|
        {
          title: article["title"],
          body: article["body"],
          event_id: article["eventUrl"],
          relevance: article["relevance"],
          sentiment: article["sentiment"],
          source: article.dig("source", "title"),
          url: article["url"],
          location: article.dig("location", "label", "eng"),
          image: article["image"],
          category_id: group[:internal_category_id]
        } unless @external_articles[article["title"]]
      end
    end
  end
end
