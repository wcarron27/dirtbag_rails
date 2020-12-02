require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'post users/' do
    it 'should return 422 with invalid email' do
      headers = { "CONTENT_TYPE" => "application/json" }
      post "/users", :params => '{ "user": { "email": "", "password": "Abcdefgh1!" } }', :headers => headers
      expect(User.count).to eq(0)
      expect(response).to have_http_status(422)
    end

    it 'should return 422 with invalid password' do
      headers = { "CONTENT_TYPE" => "application/json" }
      post "/users", :params => '{ "user": { "email": "ab@example.com", "password": "" } }', :headers => headers
      expect(User.count).to eq(0)
      expect(response).to have_http_status(422)
    end

    it 'should return 200 with valid email and password' do
      headers = { "CONTENT_TYPE" => "application/json" }
      post "/users", :params => '{ "user": { "email": "ab@example.com", "password": "Abcdefgh1!" } }', :headers => headers
      expect(User.count).to eq(1)
      expect(response).to have_http_status(200)
    end
  end
end
