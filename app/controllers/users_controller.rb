class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create( user_params )
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      render :action => :edit
    else
      render 'edit'
    end
  end

  private

    # Use strong_parameters for attribute whitelisting
    # Be sure to update your create() and update() controller methods.

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                     :password_confirmation, :avatar)
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
