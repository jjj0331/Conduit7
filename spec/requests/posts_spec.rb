require 'rails_helper'

RSpec.describe ArticlesController, type: :request do
  describe "GET /articles/:id" do
    let(:user) { FactoryBot.create(:user) }
    
    it "returns the article as JSON" do
      article = FactoryBot.create(:article, user: user)
      get "/articles/#{article.id}"

      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response['message']['id']).to eq(article.id)
      expect(json_response['message']['title']).to eq(article.title)
      expect(json_response['message']['description']).to eq(article.description)
      expect(json_response['message']['body']).to eq(article.body)
      expect(json_response['message']['tagList']).to eq(article.tagList)
    end

    it "returns nil when the article does not exist" do
      get "/articles/99999"  # Assuming this ID does not exist
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['message']).to be_nil
    end
  end
end
