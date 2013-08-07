class AddUserIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :user_id, :integer
    add_index :comments, :user_id

    Comment.all.each do |c|
      c.user = User.find(2)
    end
  end
end
