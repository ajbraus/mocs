class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tags = Tag.first(5)
    @recommended_mocs = Post.first(5)
    @mocs = Post.first(5)
    @activities = PublicActivity::Activity.order("created_at desc") #.where(owner_id: current_user.friend_ids, owner_type: "User")
  end
end