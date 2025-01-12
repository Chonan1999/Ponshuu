class RemoveProfileImageFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :profile_image, :string
  end
end
