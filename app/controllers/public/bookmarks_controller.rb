class Public::BookmarksController < ApplicationController
  before_action :authenticate_customer!

  def create
    @post = Post.find(params[:post_id])
    bookmark = @post.bookmarks.new(customer_id: current_customer.id)
    if bookmark.save
      flash[:notice] = "ブックマークに登録しました"
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    bookmark = @post.bookmarks.find_by(customer_id: current_customer.id)
    if bookmark.present?
      bookmark.destroy
      flash[:notice] = "ブックマークを解除しました"
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

end
