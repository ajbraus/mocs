class AddToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :expected_time, :integer
    add_column :posts, :actual_time, :integer
    add_column :posts, :duration, :integer
    add_column :posts, :goal, :string
  end
end