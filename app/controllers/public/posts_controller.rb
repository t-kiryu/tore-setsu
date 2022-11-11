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
      flash[:notice] = "投稿を保存しました"
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def index
    # @postsを上書きして処理進行
    # タグ検索が優先され、キーワードあればキーワード検索
    @posts= Post.all.page(params[:page]).per(10)
    @tags = Tag.all
    if params[:search].present?
      @posts = @posts.where("introduction LIKE ? ",'%' + params[:search] + '%').page(params[:page]).per(10)
    # タグ検索
    elsif params[:tag_id].present?
      @posts = Tag.find(params[:tag_id]).posts.page(params[:page]).per(10) if TagList.where(tag_id:params[:tag_id]).present?
      # (1)tag.find(params[:tag_id])                         => (3)で取得したタグ1つを検索
      # (2)post.page(params[:page]).per(10)                  => ページネーション
      # (3)if TagList.where(tag_id:params[:tag_id]).present? => (1)のparams[:tag_id]に入れるtag_idを取得
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    if @post == current_customer
      render :edit
    else
      redirect_to post_path(@post.id)
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "変更を保存しました"
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