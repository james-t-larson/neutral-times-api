require "test_helper"
require "json-schema"
require "webmock/minitest"

class OpenaiClientTest < Minitest::Test
  def setup
    @api_key = "test_api_key"
    @client = OpenaiClient.new(@api_key)
    @headline = "The Future of Renewable Energy"
  end

  def test_generate_article_success
    stubbed_response = {
      choices: [
        {
          message: {
            content: {
              article: {
                title: "The Future of Renewable Energy",
                summary: "An exploration of renewable energy trends and technologies.",
                content: "In recent years, renewable energy has been gaining traction...",
                sources: "National Renewable Energy Laboratory, IEA reports."
              }
            }.to_json
          }
        }
      ]
    }

    stub_request(:post, "https://api.openai.com/v1/chat/completions")
      .with(
        headers: { "Authorization" => "Bearer #{@api_key}" },
        body: hash_including(model: "gpt-4o")
      )
      .to_return(body: stubbed_response.to_json, headers: { "Content-Type" => "application/json" })

    response = @client.generate_article(@headline)

    assert_equal "The Future of Renewable Energy", response[:article][:title]
    assert_equal "An exploration of renewable energy trends and technologies.", response[:article][:summary]
    assert_equal "In recent years, renewable energy has been gaining traction...", response[:article][:content]
    assert_equal "National Renewable Energy Laboratory, IEA reports.", response[:article][:sources]
  end

  def test_generate_article_schema_validation
    stubbed_response = {
      choices: [
        {
          message: {
            content: {
              article: {
                title: "Renewable Energy",
                summary: "Overview of trends.",
                content: "Renewable energy is key...",
                sources: "IEA, NREL."
              }
            }.to_json
          }
        }
      ]
    }

    stub_request(:post, "https://api.openai.com/v1/chat/completions")
      .to_return(body: stubbed_response.to_json, headers: { "Content-Type" => "application/json" })

    response = @client.generate_article(@headline)

    assert JSON::Validator.validate!(OpenaiClient::RESPONSE_SCHEMA[:schema], response), "Response did not match schema"
  end

  def test_generate_article_handles_invalid_schema
    invalid_response = {
      choices: [
        {
          message: {
            content: {
              article: {
                title: "Renewable Energy"
              }
            }.to_json
          }
        }
      ]
    }

    stub_request(:post, "https://api.openai.com/v1/chat/completions")
      .to_return(body: invalid_response.to_json, headers: { "Content-Type" => "application/json" })

    error = assert_raises(OpenaiClient::ResponseValidationError) do
      @client.generate_article(@headline)
    end
    assert_match /The property '#\/article' did not contain a required property of 'summary'/, error.message
  end
end
