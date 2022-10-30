class Public::PostsController < ApplicationController
  before_action :authenticate_customer!, except: [:top, :index, :show]

  def top
  end

  def new
    @post = Post.new
  end

  #投稿確認画面 => 作成中止
  #def confirm
  #  @post = Post.new(post_params)
  #end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def index
    # ページネーション、検索を追記
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(10).search(params[:search])
    @post_tags = params[:tag_id].present? ? Tag.find(params[:tag_id]).post_tags : Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :introduction, :image, tag_ids:[])
  end
  # tag_ids:[] => 渡された複数タグを配列形式でpost_paramsに渡す
end
