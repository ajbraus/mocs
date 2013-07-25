class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tags = Tag.first(5)
    @recommended_mocs = Post.first(5)
    @mocs = Post.first(5)
    @activities = PublicActivity::Activity.order("created_at desc") #.where(owner_id: current_user.friend_ids, owner_type: "User")
  end
  def posts
    @commitments = current_user.commitments
    @posts = current_user.posts.where(published: true)
    @unpublished_posts = current_user.posts.where(published: false)
    @expired_posts = current_user.posts.where("published = ? and ends_on > ?", true, Time.now  )
  end
end