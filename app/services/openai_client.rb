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
    <<~TEXT
    Generate news articles based on the provided media fairness and balance rules. These rules are derived from notable guidelines like the Fairness Doctrine, the Canadian Broadcasting Act, the Ofcom Broadcasting Code in the UK, and the CBAA Code of Practice in Australia. Articles should adhere to these principles to ensure unbiased and balanced reporting.

    # Steps

    - **Coverage of Controversial Issues**: Ensure the article explores differing perspectives on public issues to provide a balanced and comprehensive view.
    - **Equal Time Rule**: For articles about political candidates, ensure equal space and coverage are provided for all candidates involved.
    - **Personal Attack Rule**: If critiquing or attacking individuals or groups, include their response or viewpoint for balanced coverage.
    - **Political Editorial Rule**: When endorsing candidates, include space for responses from other candidates or opposing views.
    - **Diversity and Fairness**: Present a variety of viewpoints on controversial topics and include minority perspectives, particularly on sensitive issues.
    - **Fact-Checking Rule**: Ensure all information is well-researched and supported by credible sources, verifying all factual claims.
    - **Transparency Rule**: Clearly cite sources and disclose any affiliations that may influence the article content.

    # Output Format

    - Write a complete article that fully complies with the prescribed rules.
    - The article should be well-structured with a title, introduction, body paragraphs covering multiple viewpoints, and a conclusion.
    - Clearly attribute all sources and disclose any relevant affiliations in footnotes or at the end of the article text.
    - Avoid potentially biased sources.#{' '}
    - It is vitally important that we return content in mark down.#{' '}

    (Note: Real articles should be detailed, respecting length and depth appropriate for a proper news article on similar topics.)

    # Notes

    - Thoroughly verify all claims using reputable sources.
    - Be mindful to maintain balance and impartiality.
    - Ensure minority or less-represented voices are heard in applicable sections.
    TEXT
  end

  def validate_response(data)
    JSON::Validator.validate!(RESPONSE_SCHEMA[:schema], data)
    data
  rescue JSON::Schema::ValidationError => e
    raise ResponseValidationError, "Schema validation failed: #{e.message}"
  end
end
