require "openai"

class OpenaiArticleGenerator
  def initialize(api_key = nil)
    @api_key = api_key || Rails.application.credentials.dig(:openai, :api_key)
    @client = OpenAI::Client.new(access_token: @api_key)
    @rules = YAML.load_file(Rails.root.join("config/rules", "openai_article_generator.yml"))["system_rules"]
  end

  def generate_article(content)
    @content = content
    @client.chat(
      parameters: {
        model: "gpt-4",
        messages: [
          {
            role: "system",
            content: @rules
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
