class SessionsController < ApplicationController

  def new
    render layout: "empty"
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to dashboard_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      redirect_to action: :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end
end
