class AddToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :expected_time, :integer, default: 0
    add_column :posts, :actual_time, :integer, default: 0
    add_column :posts, :duration, :integer, default: 0
    add_column :posts, :goal, :string
  end
end