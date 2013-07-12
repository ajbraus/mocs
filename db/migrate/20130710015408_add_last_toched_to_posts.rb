class AddLastTochedToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :last_touched, :datetime
  end
end
