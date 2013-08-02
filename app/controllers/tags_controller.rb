class TagsController < ApplicationController
  before_filter :authenticate_user!
  def show
    @tag = Tag.find_by_name(params[:id])
    @posts = Post.tagged_with(params[:id])
    post_ids = @posts.pluck(:id)  
  end
end