class ConduitController < ApplicationController
  
  def home
  end

  def register
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success]="Welcome to the Conduit"
      redirect_to root_url
    else
      render 'register'   
    end   
  end

  def CreateArticle
  end

  def Settings
  end

  def Article
  end

  def Profile
    @user=User.find(user_params[:id])  
  end
  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
