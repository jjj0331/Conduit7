class User < ApplicationRecord
  #saveメソッドの実行前に：emailを小文字に！！！
  before_save { email.downcase! }

  #Userモデルのバリデーション
  #presence: true           :空白文字がチェック
  #has_secure_password      :パスワードがハッシュ化されているかチェック
  #length: { maximum: 255 } :登録されるデータの長さをチェック(最大文字数:255)
  #format: {}               :emailの中に必ず@が存在する
  #unique:                  :emailを一意に　※testコード作成とDBのindexは未実施
  
  validates :username,  presence: true ,length: { maximum: 50 }
  validates :email,     presence: true ,length: { maximum: 255 },
                        format: { with: /\A[^@\s]+@[^@\s]+\z/},
                        uniqueness: true
  validates :password, presence: true, length: { minimum: 5 }
  has_secure_password
end
