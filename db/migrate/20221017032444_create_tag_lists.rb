class CreateTagLists < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_lists do |t|

      t.integer :post_id
      t.integer :tag_id
      t.timestamps
    end
  end
end
