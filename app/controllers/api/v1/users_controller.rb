class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :login]
  
# ユーザ作成  
  def create
    @user = User.new(user_params)

    if @user.save
      token = create_token(@user.id)
      render json: {user: {email: @user.email, token: token, username: @user.username}}
    else
      render json:{message:@user.errors.full_messages}
    end   
  end

  def login
    user=User.find_by(email: params[:user][:email].downcase)

    if user && user.authenticate(params[:user][:password])
      token = create_token(user.id)
      render json:{login:{token:token,message:"ログインに成功しました"}}
    else
      render json:{message:"ログインに失敗しました"}
    end  
  end

  def show
    if current_user
      render json: current_user
    else
      render json: { message: "ログインしていません" }, status: :unauthorized
    end
  end

  private 
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def create_token(user_id)
      payload = { user_id: user_id }
      secret_key = Rails.application.credentials.secret_key_base
      token = JWT.encode(payload, secret_key)
      return token
    end

    def current_user
      # Authorizationヘッダーからトークンを取得
      token = request.headers["Authorization"]&.split(" ")&.last
      
      if token
        # トークンをデコードしてユーザーIDを取得
        decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256')
        user_id = decoded_token.first["user_id"]
        
        # データベースからユーザーを取得
        @current_user ||= User.find_by(id: user_id)
      end
    end
end

