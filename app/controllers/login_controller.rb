class LoginController < ApplicationController
  def attempt_login
    if @user = User.authenticate(params[:user], params[:password])
      session[:user_id] = @user.id
      redirect_to :controller => "recipes", :action => "index"
    else
      flash[:error] = "Invalid username or password."
      redirect_to :controller => "login", :action => "index"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :controller => "login", :action => "index"
  end
end
