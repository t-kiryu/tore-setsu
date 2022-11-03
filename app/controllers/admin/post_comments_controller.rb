class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def edit
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    @post_comment.update(post_comment_params)
    flash[:notice] = "コメント表示を変更しました"
    redirect_to admin_post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :show_comment)
  end
end
