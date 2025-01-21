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
                  # Finance
                  {
                    "categoryUri": "dmoz/Society/Issues/Economic"
                  },
                  {
                    "categoryUri": "dmoz/Home/Personal_Finance"
                  },
                  {
                    "categoryUri": "dmoz/Business/Small_Business/Finance"
                  },
                  {
                    "categoryUri": "dmoz/Business/Investing"
                  },
                  {
                    "categoryUri": "dmoz/Business/Financial_Services"
                  },
                  {
                    "categoryUri": "dmoz/Business/Real_Estate"
                  },
                  # Technology
                  {
                    "categoryUri": "news/Technology"
                  },
                  {
                    "categoryUri": "dmoz/Computers"
                  },
                  {
                    "categoryUri": "dmoz/Science/Technology"
                  },
                  {
                    "categoryUri": "dmoz/Science/Software"
                  },
                  {
                    "categoryUri": "dmoz/Home/Software"
                  },
                  {
                    "categoryUri": "dmoz/Sports/Software"
                  },
                  {
                    "categoryUri": "dmoz/Business/Information_Technology"
                  },
                  {
                    "categoryUri": "dmoz/Business/Investing/Software"
                  },
                  {
                    "categoryUri": "dmoz/Arts/Graphic_Design/Software"
                  },
                  {
                    "categoryUri": "dmoz/Society/Subcultures/Cyberculture"
                  },
                  {
                    "categoryUri": "dmoz/Business/Aerospace_and_Defense/Space"
                  },
                  {
                    "categoryUri": "dmoz/Business/Arts_and_Entertainment/Gaming"
                  },

                  # Civics
                  {
                    "categoryUri": "dmoz/Society/Crime"
                  },
                  {
                    "categoryUri": "dmoz/Business/Cooperatives"
                  },
                  {
                    "categoryUri": "dmoz/Society/Issues"
                  },
                  {
                    "categoryUri": "dmoz/Society/Law"
                  },
                  {
                    "categoryUri": "dmoz/Society/Government"
                  },
                  {
                    "categoryUri": "dmoz/Society/Crime"
                  },
                  {
                    "categoryUri": "dmoz/Society/Activism"
                  },
                  {
                    "categoryUri": "dmoz/Health/Education"
                  },
                  {
                    "categoryUri": "dmoz/Business/Real_Estate/Development"
                  },
                  {
                    "categoryUri": "dmoz/Business/Real_Estate/Residential"
                  },
                  {
                    "categoryUri": "dmoz/Business/Real_Estate/Inspection"
                  },
                  {
                    "categoryUri": "dmoz/Business/Real_Estate/Legal"
                  },
                  {
                    "categoryUri": "dmoz/Society/Philanthropy/Homeless"
                  },
                  {
                    "categoryUri": "dmoz/Society/Politics/Democracy"
                  },
                  {
                    "categoryUri": "dmoz/Society/Issues/Older_Citizens"
                  },
                  {
                    "categoryUri": "dmoz/Society/Organizations/Advocacy"
                  },
                  {
                    "categoryUri": "dmoz/Health/Public_Health_and_Safety"
                  },
                  {
                    "categoryUri": "dmoz/Business/Construction_and_Maintenance/Residential_Housing"
                  },
                  {
                    "categoryUri": "dmoz/Health/Public_Health_and_Safety/Community_Health"
                  },
                  {
                    "categoryUri": "dmoz/Society/Politics/Campaigns_and_Elections"
                  },
                  {
                    "categoryUri": "dmoz/Society/Government/Parliaments_and_Legislatures"
                  },
                  {
                    "categoryUri": "dmoz/Health/Public_Health_and_Safety/Policy_and_Regulation"
                  },
                  {
                    "categoryUri": "dmoz/Society/Issues/Human_Rights_and_Liberties"
                  },
                  {
                    "categoryUri": "dmoz/Society/Issues/Crime_and_Justice"
                  },
                  {
                    "categoryUri": "dmoz/Society/Politics/Civic_Participation"
                  },
                  {
                    "categoryUri": "dmoz/Society/Politics/Conservatism"
                  },
                  {
                    "categoryUri": "dmoz/Society/Politics/Fascism"
                  },
                  {
                    "categoryUri": "dmoz/Society/Politics/Federalism_and_Devolution"
                  },
                  {
                    "categoryUri": "dmoz/Business/International_Business_and_Trade/International_Taxation"
                  }
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
