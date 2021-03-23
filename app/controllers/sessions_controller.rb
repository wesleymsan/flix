class SessionsController < ApplicationController
  def new    
  end

  def create
    user = User.where(email: params[:login]).or(User.where(username: params[:login])).take
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to (session[:intended_url] || user),
                  notice: "Welcome back, #{user.name}!"
      session[:intended_url] = nil
    else
      flash.now[:alert] = 'Invalid email/password combination!'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_url, notice: "You're now signed out!"
  end
end
