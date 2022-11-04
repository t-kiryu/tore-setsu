class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "変更を保存しました"
      redirect_to admin_customer_path(@customer.id)
    else
      render :edit
    end
  end

  def bookmark
    bookmarks = Bookmark.where(customer_id: params[:id]).pluck(:post_id)
    @bookmark_list = Post.find(bookmarks)
    @customer = Customer.find(params[:id])
  end

  def my_post
    @customer = Customer.find(params[:id])
    @customer_post = @customer.posts.page(params[:page]).per(10)
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :user_name, :email, :is_deleted)
  end
end
