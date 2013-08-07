class CreateGoalsPostsTable < ActiveRecord::Migration
  def self.up
    create_table :goals_posts, :id => false do |t|
      t.references :post
      t.references :goal
    end
    add_index :goals_posts, [:post_id, :goal_id]
    add_index :goals_posts, [:goal_id, :post_id]

    remove_column :posts, :goal
  end

  def self.down
    drop_table :goals_posts
  end
end