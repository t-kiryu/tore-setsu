class Public::PostCommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    post = Post.find(params[:post_id])
    comment = current_customer.post_comment.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(past)
  end

  def destroy

  end

  private

  def post_comment_parmas
    params.require(:post).permit(:commnet)
  end
end
