class ConduitController < ApplicationController
  def home
  end

  def register
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      render 'home'
    end   
  end
  
  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
