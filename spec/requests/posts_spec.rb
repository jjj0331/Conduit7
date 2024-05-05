require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  describe "POST /users" do
    let(:user_params) { { email: "test@example.com", password: "password", username: "testuser" } }

    it "returns the newly created user as JSON" do
      # POSTリクエストでユーザーを新規作成
      post "/api/v1/users", params: { user: user_params }

      # レスポンスが成功しているかを確認
      expect(response).to have_http_status(200)

      # JSONレスポンスを解析し、必要なフィールドが正しいかを確認
      json_response = JSON.parse(response.body)

      expect(json_response['user']['email']).to eq(user_params[:email])
      expect(json_response['user']['username']).to eq(user_params[:username])
      expect(json_response['user']['token']).to be_present
    end
  end
end
