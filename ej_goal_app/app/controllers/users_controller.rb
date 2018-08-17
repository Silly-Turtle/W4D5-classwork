class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      render :new    #TODO we will change this later
    else
      flash[:errors] = ['invalid parameters']
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :password)
  end
end
