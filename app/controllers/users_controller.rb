class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:org_name]
  def show
    @user = User.find(params[:id])
    if user_signed_in? && current_user == @user
      @activities = PublicActivity::Activity.where(owner_id: current_user.id, owner_type: "User").order("created_at desc").paginate(:page => params[:page], :per_page => 5) #.where(owner_id: current_user.friend_ids, owner_type: "User")
    end

    @commitments = @user.committed_tos.where('progress < 6')
    @completed = @user.committed_tos.where("progress >= 6")
  end
  
  def posts
    @posts = current_user.posts.where(published: true)
    @unpublished_posts = current_user.posts.where(published: false)
    @expired_posts = current_user.posts.where("published = ? and ends_on > ?", true, Time.now  )
    @recommended_mocs = Post.where(published: true).first(3)
  end

  def index
    if current_user.admin?
      @unconfirmed_users = User.where("confirmed_at IS NULL").paginate(:page => params[:page], :per_page => 10)
      @confirmed_users = User.where("confirmed_at IS NOT NULL").paginate(:page => params[:page], :per_page => 10)
      @rejected_users = User.where("rejected_at IS NOT NULL").paginate(:page => params[:page], :per_page => 10)
      @published_posts = Post.where(published: true).paginate(:page => params[:page], :per_page => 10)
      @unpublished_posts = Post.where(published: false).paginate(:page => params[:page], :per_page => 10)
    else 
      redirect_to root_path, notice: "Oops, here you go!"
    end
  end

  def confirm
    @user = User.find(params[:user_id])
    @user.confirmed_at = Time.now
    @user.rejected_at = nil
    @user.save

    respond_to do |format|
      format.html { redirect_to users_path, notice:"User successufly confirmed" }
      format.js
      format.json { render json: @user }
    end  
  end

  def reject
    @user = User.find(params[:user_id])
    @user.rejected_at = Time.now
    @user.confirmed_at = nil
    @user.save

    respond_to do |format|
      format.html { redirect_to users_path, notice:"User successufly rejected" }
      format.js
      format.json { render json: @user }
    end  
  end

  def org_name
    @org_names = Organization.order(:name).where("lower(name) like ?", "%#{params[:term].downcase}%")
    render json: @org_names.map(&:name)
  end
end