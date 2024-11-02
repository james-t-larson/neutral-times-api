require "test_helper"

class NewsApiClientTest < Minitest::Test
  def setup
    @api_key = "test_api_key"
    @client = NewsApiClient.new(@api_key)
  end

  def test_fetch_top_headlines
    stubbed_response = {
      status: "ok",
      totalResults: 10,
      articles: [
        { title: "Headline 1", description: "Description 1" },
        { title: "Headline 2", description: "Description 2" }
      ]
    }.to_json

    stub_request(:get, "https://newsapi.org/v2/top-headlines")
      .with(query: hash_including({ country: "us", apiKey: @api_key }))
      .to_return(body: stubbed_response, headers: { "Content-Type" => "application/json" })

    response = @client.fetch_top_headlines

    assert_equal 200, response.code
    json_response = JSON.parse(response.body)
    assert_equal "ok", json_response["status"]
    assert_equal 10, json_response["totalResults"]
    assert_equal "Headline 1", json_response["articles"][0]["title"]
  end

  def test_fetch_everything
    stubbed_response = {
      status: "ok",
      totalResults: 5,
      articles: [
        { title: "Article 1", description: "Description 1" },
        { title: "Article 2", description: "Description 2" }
      ]
    }.to_json

    stub_request(:get, "https://newsapi.org/v2/everything")
      .with(query: hash_including({ q: "ruby", apiKey: @api_key }))
      .to_return(body: stubbed_response, headers: { "Content-Type" => "application/json" })

    response = @client.fetch_everything("ruby")

    assert_equal 200, response.code
    json_response = JSON.parse(response.body)
    assert_equal "ok", json_response["status"]
    assert_equal 5, json_response["totalResults"]
    assert_equal "Article 1", json_response["articles"][0]["title"]
  end
end
