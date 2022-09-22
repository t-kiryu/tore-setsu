class Public::PostsController < ApplicationController
  before_action :authenticate_customer!, except: [:top, :index, :show]

  def top
  end

  def new
    @post = Post.new
  end

  def confirm
    @post = Post.new(post_params)
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to post_path(@post.id)
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
  end

  private

  def post_params
    params.require(:post).permit(:title, :introduction)
  end
end
