require 'rails_helper'

RSpec.describe 'API::V1::DataController', type: :request do
  let(:path) { Rails.root.join('spec', 'fixtures', 'examples', 'data_test.txt') }
  let(:file) { fixture_file_upload(path, 'text/plain') }
  describe 'POST #process_data' do
    context 'when successful' do
      it 'returns success' do
        post '/api/v1/data/process_data', params: { file: file }
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to include('application/json')
        expect(json_response).to be_a(Array)
      end
    end
    context 'when file is not sent' do
      it 'returns error status' do
        post '/api/v1/data/process_data'
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(:internal_server_error)
        expect(json_response["error"]).to eq("File does not exist")
      end
    end

    context 'when request has additional parameters' do
      it 'recognizes parameters and filters results' do
        post '/api/v1/data/process_data', params: { file: file,
                                                    order_ids: [111, 222],
                                                    start_date: '2024-01-01',
                                                    end_date: '2024-12-31' }
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)

        json_response.each do |user|
          user['orders'].each do |order|
            expect([123, 456]).to include(order['order_id'])
            expect(order['date']).to be >= '2024-01-01'
            expect(order['date']).to be <= '2024-12-31'
          end
        end
      end
    end

    context 'when request does not have aditional parameters' do
      it 'return data successfully without parameters' do
        post '/api/v1/data/process_data', params: { file: file }

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response).to be_a(Array)
      end
    end
  end
end
