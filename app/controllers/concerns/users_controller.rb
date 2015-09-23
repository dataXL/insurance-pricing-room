class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'Avatar was successfully uploaded.'
     else
       render action: 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render action: 'show'
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :name)
  end
end