class AddCategoryIdToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :category_id, :integer
    add_index :posts, :category_id
  end
end
