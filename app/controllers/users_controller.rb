class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:org_name]
  def show
    @user = User.find(params[:id])
    @tags = Tag.first(5)
    @activities = PublicActivity::Activity.order("created_at desc") #.where(owner_id: current_user.friend_ids, owner_type: "User")
    @trending_tags = Tag.first(10)
  end
  
  def posts
    @commitments = current_user.committed_tos.where('progress < 6')
    @completed = current_user.committed_tos.where("progress >= 6")
    @posts = current_user.posts.where(published: true)
    @unpublished_posts = current_user.posts.where(published: false)
    @expired_posts = current_user.posts.where("published = ? and ends_on > ?", true, Time.now  )
    @trending_tags = Tag.first(15)
    @recommended_mocs = Post.where(published: true).first(3)
  end

  def org_name
    @org_names = Organization.order(:name).where("lower(name) like ?", "%#{params[:term].downcase}%")
    render json: @org_names.map(&:name)
  end
end