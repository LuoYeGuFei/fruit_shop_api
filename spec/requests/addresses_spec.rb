require 'rails_helper'

RSpec.describe 'Addresses API' do
  let!(:customer) { create(:customer) }
  let!(:addresses) { create_list(:address, 10, customer_id: customer.id)}
  let(:customer_id) { customer.id }
  let(:id) { addresses.first.id }

  # Test suite for GET /customers/:customer_id/addresses
  describe 'GET /customers/:customer_id/addresses' do
    before { get "/customers/#{customer_id}/addresses" }

    context 'when customer exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all customer addresses' do
        expect(json.size).to eq(10)
      end
    end

    context 'when customer does not exist' do
      let(:customer_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Customer/)
      end
    end
  end

  # Test suite for GET /customers/:customer_id/addresses/:id
  describe 'GET /customers/:customer_id/addresses/:id' do
    before { get "/customers/#{customer_id}/addresses/#{id}"}

    context 'when customer address exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the address' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when customer address does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Address/)
      end
    end
  end

  # Test suite for POST /customers/:customer_id/addresses
  describe 'POST /customers/:customer_id/addresses' do
    let(:valid_attrs) { { receiver: 'lj001', tel: '13454364387', addr: 'Beijing' } }

    context 'when request attributes are valid' do
      before { post "/customers/#{customer_id}/addresses", params: valid_attrs }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request attribute is invalid' do
      before { post "/customers/#{customer_id}/addresses", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed:/)
      end
    end
  end

  # Test suite for PUT /customers/:cutomer_id/addresses/:id
  describe 'PUT /customers/:customer_id/addresses/:id' do
    let(:valid_attrs) { { receiver: 'lj001', tel: '13436754328', addr: 'Wuhan' } }

    before { put "/customers/#{customer_id}/addresses/#{id}", params: valid_attrs }

    context 'when address exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the address' do
        addr = Address.find(id)
        expect(addr.receiver).to eq('lj001')
      end
    end

    context 'when the address does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Address/)
      end
    end
  end

  # Test suite for DELETE /customers/:customer_id/addresses/:id
  describe 'DELETE /customers/:customer_id/addresses/:id' do
    before { delete "/customers/#{customer_id}/addresses/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
