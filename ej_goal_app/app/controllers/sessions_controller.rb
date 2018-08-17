class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:name], params[:user][:password])
    if user
      log_in!(user)
      render :new #dummy render. will switch later
    else
      flash.now[:errors] = ["invalid credentials"]
      render :new
    end
  end

  def destroy
    log_out!(current_user)
    render :new
  end

end
