class ChildrenController < ApplicationController
  before_action :require_current_user!

  def new
    @child = Child.new
    render :new
  end

  def create
    @child = Child.new(child_params)
    if @child.save
      redirect_to child_url(@child)
    else
      flash.now[:errors] = @child.errors.full_messages
      render :new
    end
  end

  def edit
    @child = Child.find(params[:id])
    render :edit
  end

  def update
    @child = Child.find(params[:id])
    if @child.update(child_params)
      redirect_to child_url(params[:id])
    else
      flash.now[:errors] = @child.errors.full_messages
      @child = Child.new(child_params.merge(id: params[:id]))
      render :edit
    end
  end

  def show
    @child = Child.find(params[:id])
    render :show
  end

  def index
    render :index
  end

  def destroy
    @child.find(params[:id])
    @child.destroy
    redirect_to children_url
  end

  private
  def child_params
    params.require('child').permit(:name, :description, :picture, :user_id)
  end
end
