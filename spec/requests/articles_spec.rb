# spec/requests/articles_spec.rb
require 'swagger_helper'

RSpec.describe 'Articles API', type: :request do
  before do
    @article = create(:article)
  end

  path '/articles' do
    get 'Retrieves articles from today' do
      tags 'Articles'
      produces 'application/json'
      parameter name: :date, in: :query, type: :string, required: false, description: 'Optional date filter in ISO 8601 format'

      response '200', 'articles found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   summary: { type: :string },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' },
                   content: { type: :string },
                   sources: { type: :string }
                 },
                 required: [ 'id', 'title', 'summary', 'created_at', 'updated_at', 'content', 'sources' ]
               }

        run_test! do |response|
          json_response = JSON.parse(response.body)

          expect(response).to have_http_status(:success)
          expect(json_response.length).to eq(1)

          article_data = json_response.first
          expect(article_data['id']).to eq(@article.id)
          expect(article_data['title']).to eq(@article.title)
          expect(article_data['summary']).to eq(@article.summary)
          expect(article_data['created_at']).to eq(@article.created_at.as_json)
          expect(article_data['updated_at']).to eq(@article.updated_at.as_json)
          expect(article_data['content']).to eq(@article.content.as_json)
          expect(article_data['sources']).to eq(@article.sources.as_json)
        end
      end

      response '422', 'invalid date format' do
        let(:date) { "2024-17-04" }

        schema type: :object,
          properties: {
            message: { type: :string },
            code: { type: :int },
            data: { type: :object }
          },
          required: [ 'error' ]

        run_test! do |response|
          json_response = JSON.parse(response.body)

          expect(response.status).to eq(422)

          expect(json_response['error']).to eq("Parameter date is invalid. ISO-8601 is required")
        end
      end
    end
  end

  path '/articles/{id}' do
    get 'Retrieves a specific article' do
      tags 'Articles'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'ID of the article'

      response '200', 'article found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 summary: { type: :string },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' },
                 content: { type: :string },
                 sources: { type: :string }
               },
               required: [ 'id', 'title', 'summary', 'created_at', 'updated_at', 'content', 'sources' ]

        let(:id) { @article.id }

        run_test! do |response|
          json_response = JSON.parse(response.body)

          expect(response).to have_http_status(:success)
          expect(json_response['id']).to eq(@article.id)
          expect(json_response['title']).to eq(@article.title)
          expect(json_response['summary']).to eq(@article.summary)
          expect(json_response['created_at']).to eq(@article.created_at.as_json)
          expect(json_response['updated_at']).to eq(@article.updated_at.as_json)
          expect(json_response['content']).to eq(@article.content.as_json)
          expect(json_response['sources']).to eq(@article.sources.as_json)
        end
      end

      response '404', 'article not found' do
        let(:id) { -1 }

        schema type: :object,
          properties: {
            message: { type: :string },
            code: { type: :int },
            data: { type: :object }
          },
          required: [ 'message' ]

        run_test! do |response|
          json_response = JSON.parse(response.body)

          expect(response).to have_http_status(:not_found)
          expect(json_response['message']).to eq("Record not found")
        end
      end
    end
  end
end
