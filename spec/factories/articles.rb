# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    # 仮のユーザー属性を定義します
    name { "John Doe" }
    email { "john@example.com" }
    password{"password"}
  end
end

# spec/factories/articles.rb
FactoryBot.define do
  factory :article do
    title { "Sample Article" }
    description { "Short description of the article." }
    body { "This is the body of the article." }
    tagList { ["tag1", "tag2"] }
    user
  end
end
