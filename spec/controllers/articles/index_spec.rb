require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe 'GET #index' do
    let!(:today_articles) { create_list(:article, 3) }

    context 'without a date parameter' do
      it 'returns articles published today' do
        allow(Article).to receive(:published_today).and_return(today_articles)

        get :index
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(3)
      end
    end

    context 'with a valid date parameter' do
      let(:date) { DateTime.now.iso8601 }
      let(:dated_articles) { create_list(:article, 2) }

      it 'returns articles published between the given date' do
        allow(Article).to receive(:published_between).with(any_args).and_return(dated_articles)

        get :index, params: { date: date }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(2)
      end
    end

    context 'with an invalid date parameter' do
      it 'returns an error with invalid date format' do
        get :index, params: { date: '2024-23-23' }
        expect(response).to have_http_status(:unprocessable_content)
        expect(JSON.parse(response.body)['error']).to include('Parameter date is invalid')
      end
    end
  end
end
