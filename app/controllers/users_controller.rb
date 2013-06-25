class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tags = Tag.first(5)
    @recommended_mocs = Post.first(5)
    @mocs = Post.first(5)
  end
end