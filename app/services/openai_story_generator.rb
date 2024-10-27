require "openai"

class OpenaiStoryGenerator
  def initialize(content, api_key)
    @api_key = api_key || Rails.application.credentials.dig(:openai, :api_key)
    @client = OpenAI::Client.new(access_token: @api_key)
    @content = content
  end

  def generate_article
    @client.chat(
      parameters: {
        model: "gpt-4",
        messages: [
          {
            role: "system",
            content: <<~RULES
            Generate news articles based on the provided media fairness and balance rules...
            # (include all the content rules as needed)
            RULES
          },
          { role: "user", content: @content }
        ],
        temperature: 1,
        max_tokens: 2048,
        top_p: 1,
        frequency_penalty: 0,
        presence_penalty: 0
      }
    )
  end
end
