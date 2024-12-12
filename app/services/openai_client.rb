require "httparty"
require "json-schema"
require "json"

class OpenaiClient
  include HTTParty
  base_uri "https://api.openai.com"

  class ResponseValidationError < StandardError; end

  COMPLETIONS_ROUTE = "/v1/chat/completions"

  RESPONSE_SCHEMA = {
    name: "article_schema",
    strict: true,
    schema: {
      type: "object",
      properties: {
        article: {
          type: "object",
          properties: {
            title: {
              type: "string",
              description: "The title of the article."
            },
            summary: {
              type: "string",
              description: "A short summary of the article."
            },
            content: {
              type: "string",
              description: "The main content of the article."
            },
            sources: {
              type: "string",
              description: "The sources for supporting the article."
            }
          },
          required: [ "title", "summary", "content", "sources" ],
          additionalProperties: false
        }
      },
      required: [ "article" ],
      additionalProperties: false
    }
  }

  def initialize(api_key = nil)
    @api_key = api_key || Rails.application.credentials.dig(:openai, :api_key)
  end

  def generate_article(article)
    response = self.class.post(
      COMPLETIONS_ROUTE,
      headers: {
        "Authorization" => "Bearer #{@api_key}",
        "Content-Type" => "application/json"
      },
      body: request_payload(article).to_json
    )

    article_data = JSON.parse(response["choices"].first["message"]["content"], symbolize_names: true)
    update_sentiment(article_data[:article][:content])
    validate_response(article_data)
  end

  private

  def request_payload(headline)
    {
      model: "gpt-4o",
      messages: [
        {
          role: "system",
          content: [
            {
              type: "text",
              text: system_instructions
            }
          ]
        },
        {
          role: "user",
          content: [
            {
              type: "text",
              text: headline
            }
          ]
        }
      ],
      temperature: 1,
      max_tokens: 2048,
      top_p: 1,
      frequency_penalty: 0,
      presence_penalty: 0,
      response_format: {
        type: "json_schema",
        json_schema: RESPONSE_SCHEMA
      }
    }
  end

  def system_instructions
    @prompt ||= Prompt.first
    @system_instructions ||= @prompt.text
  end

  def sentiment_analyzer
    @sentiment_analyzer ||= Sentimental.new
    @sentiment_defaults ||= @sentiment_analyzer.load_defaults
    @sentiment_analyzer
  end

  def update_sentiment(article)
    score = sentiment_analyzer.score(article)
    current_average = @prompt.sentiment
    current_count = @prompt.usage_count

    new_count = current_count + 1

    new_average = ((current_average * current_count) + score) / new_count

    Rails.logger.info "Updating sentiment:
      Article score: #{score},
      Current average: #{current_average},
      Current count: #{current_count},
      New count: #{new_count},
      New average: #{new_average}"

    @prompt.update_columns(sentiment: new_average, usage_count: new_count)
  end

  def validate_response(data)
    JSON::Validator.validate!(RESPONSE_SCHEMA[:schema], data)
    data
  rescue JSON::Schema::ValidationError => e
    raise ResponseValidationError, "Schema validation failed: #{e.message}"
  end
end
