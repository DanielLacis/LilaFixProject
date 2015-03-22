class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(user_params[:email], user_params[:password])
    if @user.nil?
      flash.now[:errors] = ["Email not found or invalid password"]
      @user = User.new(user_params)
      render :new
    else
      login!(@user)
      redirect_to children_url
    end
  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
