class UsersController < ApplicationController
  before_filter :authenticate_user!
  def show
    @user = User.find(params[:id])
    @tags = Tag.first(5)
    @recommended_mocs = Post.first(5)
    @activities = PublicActivity::Activity.order("created_at desc") #.where(owner_id: current_user.friend_ids, owner_type: "User")
    @trending_tags = Tag.first(10)
  end
  def posts
    @commitments = current_user.committed_tos.where('progress < 6')
    @completed = current_user.committed_tos.where("progress >= 6")
    @posts = current_user.posts.where(published: true)
    @unpublished_posts = current_user.posts.where(published: false)
    @expired_posts = current_user.posts.where("published = ? and ends_on > ?", true, Time.now  )
    @recommended_mocs = Post.first(5)
    @trending_tags = Tag.first(15)
  end
end