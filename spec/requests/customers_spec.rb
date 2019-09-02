require 'rails_helper'

RSpec.describe 'Customers API', type: :request do

  let(:user) { create(:user) }
  let!(:customers) { create_list(:customer, 10, user_id: user.id) }
  let(:customer_id) { customers.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /customers
  describe 'GET /customers' do
    before { get '/customers', params: {}, headers: headers }

    it 'returns customers' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /customers/:id
  describe 'GET /customers/:id' do
    before { get "/customers/#{customer_id}", params: {}, headers: headers }

    context "when the record exists" do
      it "returns the customer" do
        expect(json).not_to be_empty
        expect(json['id']).to eq(customer_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:customer_id) { 1000 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Customer/)
      end
    end
  end

  # Test suite for POST /customers
  describe 'POST /customers' do
    let(:valid_attrs) { { name: "lyz", wechat: "wxi3442" }.to_json }

    context 'when the request is valid' do
      before { post "/customers", params: valid_attrs, headers: headers }

      it "creates a customer" do
        expect(json['name']).to eq("lyz")
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      before { post "/customers", params: { name: "lyz" }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Wechat can't be blank/)
      end
    end
  end

  # Test suite for PUT /customers/:id
  describe 'PUT /customers/:id' do
    let(:valid_attrs) { { name: 'lyz001' }.to_json }

    context 'when the record exists' do
      before { put "/customers/#{customer_id}", params: valid_attrs, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /customers/:id
  describe 'DELETE /customers/:id' do
    before { delete "/customers/#{customer_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
