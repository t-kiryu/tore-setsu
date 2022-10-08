class RenameShowCommentsColumnToPostComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :post_comments, :show_comments, :show_comment

  end
end
