class UsersController < ApplicationController
  #before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  #before_action :correct_user,   only: [:edit, :update]
  #before_action :admin_user,     only: :destroy

  def index
    @user = User.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    # Generate random base64 password
    @user.password = @user.password_confirmation =  SecureRandom.base64(8)

    if @user.save
      @user.send_activation_email
      #flash[:info] = "Please check your email to activate your account."
      redirect_to :action => :index
    else
      render 'index'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      render :action => :show
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def destroy_multiple

    params[:users_ids].each do |id|
      User.find(id.to_i).destroy
    end

    if request.xhr?
      render :js => "window.location = '/users'"
    else
      respond_to do |format|
        format.html { redirect_to :action => "index" }
      end
    end
  end

  private

    # Use strong_parameters for attribute whitelisting
    # Be sure to update your create() and update() controller methods.

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :picture)
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
