class Api::V1::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create,:update,:get]
  
  def show
    if current_user
      render json: current_user
    else
      render json: { message: "ログインしていません" }, status: :unauthorized
    end
  end

  def get
    id = params[:id]
    @article=Article.find_by(id:id)
    render json:{message:@article}
  end

  def create
    @article=Article.new(article_params)
    if current_user
      @article.user_id=current_user.id
      if @article.save
        render json:{message:"保存に成功しました"}
      else
        render json:{message:@article.errors.full_messages}
      end
    else
      render json:{message:"ログインユーザが存在しません"}
    end
  end

  def update
    id = params[:id]
    @article=Article.find_by(id:id)
    current_user

    if @article&&@article.user_id=@current_user.id
      @article.update(article_params)
      render json:{message:@article}
    else
      render json:{message:"ユーザがいないか、ログインユーザと記事の作成者が違います"}
    end
  end

  def delete
    id = params[:id]
    @article=Article.find_by(id:id)
    current_user

    if @article&&@article.user_id=@current_user.id
      @article.destroy
      render json:{message:@article}
    else
      render json:{message:"ユーザがいないか、ログインユーザと記事の作成者が違います"}
    end
  end

  private 
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def article_params
      params.require(:article).permit(:title, :description, :body ,:tagList)
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