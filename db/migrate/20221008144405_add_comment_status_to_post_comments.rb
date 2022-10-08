class AddCommentStatusToPostComments < ActiveRecord::Migration[6.1]
  def change
    add_column :post_comments, :show_comments, :boolean, default: true

  end
end
