class ChangeCertifiedToCreditsOnPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :certified
    add_column :posts, :credits, :integer, default: 0
  end
end
