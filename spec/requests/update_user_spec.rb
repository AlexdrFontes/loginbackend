require 'rails_helper'
require 'spec_helper'

describe 'user update', type: :request do
  let(:user) { create :user }
  let(:update_params) { { user: { name: user.name } } }
  let(:token) { WebToken.encode(user) }
  let(:headers) { { 'ACCEPT': 'application/json', 'Authorization': "Bearer #{ token }" } }

  before do
    patch(
      "/v1/users/#{user.id}",
      params: update_params,
      headers: headers
    )
  end

  context 'request with user token' do
    context 'update request params' do

      it 'returns user name' do
        json = JSON(response.body)
        expect(json['user']['name']).to eq(user.name)
      end

      it 'returns user email' do
        json = JSON(response.body)
        expect(json['user']['email']).to eq(user.email)
      end

      it 'returns user token' do
        json = JSON(response.body)
        expect(json['meta']['jwt']['token']).not_to be_empty
      end

      # it 'returns user presign_object' do
      #   expect(json['meta']['presign_object']).not_to be_empty
      # end

      # it 'returns user presign_object' do
      #   expect(json['meta']['presign_object']['presigned_url']).not_to be_empty
      # end

      it 'returns user image_url' do
        json = JSON(response.body)
        expect(json['user']['images'][0]).not_to be_empty
      end

      describe '#image' do
        subject {user.images }
        it { is_expected.to be_an_instance_of(ActiveStorage::Attached::Many) }
      end


      it 'responds with a 200 status' do
        expect(response.status).to eq 200
      end
    end
  end

  context 'request without user token' do
    let(:headers) { { 'ACCEPT': 'application/json' } }
    it 'responds with a 401 status' do
      expect(response.status).to eq 401
    end
  end
end
