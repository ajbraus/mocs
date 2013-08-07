class CreateGoalsPostsTable < ActiveRecord::Migration
  def self.up
    create_table :goals_posts, :id => false do |t|
      t.references :post
      t.references :goal
    end
    add_index :goals_posts, [:post_id, :goal_id]
    add_index :goals_posts, [:goal_id, :post_id]
  end

  def self.down
    drop_table :goals_posts
  end
  
  Post.all.each do |p|
    if p.goal == "Patient Outcomes"
      p.goals << Goal.find(1)
    elsif p.goal == "Patient Satisfaction"
      p.goals << Goal.find(2)
    elsif p.goal == "Work Process"
      p.goals << Goal.find(3)
    else
      p.goals << Goal.find(2)
    end
  end

  remove_column :posts, :goal
end