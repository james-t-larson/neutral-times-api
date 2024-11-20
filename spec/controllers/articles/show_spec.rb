require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe 'GET #show' do
    let!(:article) { create(:article) }

    context 'with a valid article ID' do
      it 'returns the article as JSON' do
        get :show, params: { id: article.id }
        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response['id']).to eq(article.id)
        expect(json_response['title']).to eq(article.title)
        expect(json_response['content']).to eq(article.content)
      end
    end

    context 'with a non-existing article ID' do
      it 'returns a not found error' do
        get :show, params: { id: -1 }
        expect(response).to have_http_status(:not_found)

        json_response = JSON.parse(response.body)
        expect(json_response['error']).to include('Article not found')
      end
    end

    context 'with an invalid article ID parameter' do
      it 'returns an error for invalid ID type' do
        get :show, params: { id: 'abc' }
        expect(response).to have_http_status(:unprocessable_content)

        json_response = JSON.parse(response.body)
        expect(json_response['error']).to include("'abc' is not a valid Integer")
      end
    end
  end
end
