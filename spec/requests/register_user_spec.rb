require 'rails_helper'
require 'spec_helper'

describe 'User is Registered', type: :request do
  let(:user) { build :user }
  let(:register_params) { { name: user.name, email: user.email, password: user.password }  }
  let(:headers) { { 'ACCEPT': 'application/json' } }

  before do
    post(
      "/v1/users",
      params: register_params,
      headers: headers
    )
  end

  context 'without a email' do
    let(:register_params) { { password: 123456, name: user.name, }  }
    it 'responds with a 204 status (no content)' do
      expect(response.status).to eq 204
    end
  end

  context 'with valid params' do
    it 'responds 200 ' do
      expect(response.status).to eq 200
    end

    it 'returns a token' do
      json = JSON(response.body)
      expect(json['jwt']['token']).not_to be_nil
    end
  end

end