class PostsController < ApplicationController
  before_action :require_current_user!
  before_action :require_owner!, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to child_posts_url(@post.child)
    else
      flash.now[:errors] = @post.errors.full_messages
      render new
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
    render :edit
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find_by_id(params[:id])
    render :show
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    @post.destroy
    redirect_to child_posts_url(@post.child)
  end

  def index
    @child = Child.find_by_id(params[:child_id])
    @posts = @child.posts.order('created_at DESC').paginate(page: params[:page], per_page: 10)
    render :index
  end

  private

  def post_params
    params.require('post').permit(:user_id, :child_id, :content, :picture)
  end

  def require_owner!
    post = Post.find_by_id(params[:id])
    unless current_user.id == post.user_id
      redirect_to child_posts_url(post.child_id)
    end
  end
end
