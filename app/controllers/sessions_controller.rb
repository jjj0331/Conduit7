class SessionsController < ApplicationController
  # GET /login
  def new
  end

  # POST /login
  def create
    user=User.find_by(email: params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])
      reset_session
      log_in user
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end  
  end
  
  def destroy
    log_out
    redirect_to root_url
  end

end
