class UsersController < ApplicationController
  before_action :redirect_to_login, except: [:create, :new]

  def index
    render :index
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      User.new(user_params.merge(id: params[:id]))
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render :index
  end

  def show
    @user = User.find(params[:id])
    render :show
  end
end
