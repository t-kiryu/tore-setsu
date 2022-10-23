class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    #@posts = Post.all
    @posts = Post.order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
  #  @post = Post.find(params[:id])
  #  @post.update(post_params)
  #  redirect_to
  end

  def delete
  end

  private

  def post_params
  end

end
