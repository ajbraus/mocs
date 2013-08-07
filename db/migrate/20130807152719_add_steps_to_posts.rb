class AddStepsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :info, :text
    add_column :posts, :baseline, :text
    add_column :posts, :plan_do, :text
    add_column :posts, :post_test, :text
    add_column :posts, :wrap_up, :text
  end
end
