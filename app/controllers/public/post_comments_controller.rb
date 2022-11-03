class Public::PostCommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_customer.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    if @post_comment.save
      flash[:notice] = "コメントを保存しました"
      redirect_to post_path(@post)
    else
      # 他のコントローラにあるアクションへ遷移する時の記述
      render template: "public/posts/show"
    end
  end

  def destroy
    PostComment.find(params[:id]).destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
