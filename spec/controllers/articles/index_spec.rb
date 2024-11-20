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

      it 'returns an empty array if no articles are published today' do
        allow(Article).to receive(:published_today).and_return([])

        get :index
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq([])
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

      it 'returns an empty array if no articles are published for the given date' do
        allow(Article).to receive(:published_between).with(any_args).and_return([])

        get :index, params: { date: date }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq([])
      end
    end

    context 'with an invalid date parameter' do
      it 'returns an error with invalid date format' do
        get :index, params: { date: '2024-23-23' }
        expect(response).to have_http_status(:unprocessable_content)
        expect(JSON.parse(response.body)['error']).to include('Parameter date is invalid')
      end
    end

    context 'with a future date parameter' do
      it 'returns an error for future dates' do
        future_date = (DateTime.now + 1.day).iso8601

        get :index, params: { date: future_date }
        expect(response).to have_http_status(:unprocessable_content)

        json_response = JSON.parse(response.body)
        expect(json_response['error']).to include('Date cannot be in the future')
      end
    end

    context 'with a missing or unexpected parameter' do
      it 'handles missing date parameter gracefully' do
        expect { get :index, params: { wrong_param: 'value' } }.not_to raise_error
      end
    end

    context 'edge cases with date formats' do
      it 'handles timezone edge cases properly' do
        edge_date = '2024-11-19T23:59:59+00:00'
        allow(Article).to receive(:published_between).with(any_args).and_return(today_articles)

        get :index, params: { date: edge_date }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(3)
      end
    end
  end
end
