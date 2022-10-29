class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    render :show
  end

  # 退会確認画面
  def unsubscribe
  end

 # 退会処理
  def withdrawal
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  #def bookmark
  #  bookmarks = Bookmark.where(customer_id: current_customer.id).pluck(:post_id)
  #  @bookmark_list = Post.find(bookmarks)
  #end


  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :user_name, :email, :is_deleted)
  end

end
