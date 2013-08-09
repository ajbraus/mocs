class FixingSearchParams < ActiveRecord::Migration
  def change
    #TRACK ORGANIZATION PER POST
    add_column :posts, :organization_id, :integer
    #REMOVE HABTM FOR GOALS_POSTS
    add_column :posts, :goal_id, :integer    

    Post.all.each do |p|
      p.organization_id = p.user.organization.id
      p.goal_id = p.goals.first.id
      p.save
    end

    drop_table :goals_posts
  end
end
