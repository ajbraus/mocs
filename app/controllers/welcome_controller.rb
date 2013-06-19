class WelcomeController < ApplicationController
  def index
  	if user_signed_in?
  		@my_posts = current_user.committed_tos
  		tag_ids = []
  		@my_posts.each do |p| 
        ids = p.tags.pluck(:id)
        ids.each do |id|
          unless tag_ids.include?(id)
            tag_ids.push(id)
          end
        end
      end
  		if tag_ids.present?
  			@my_tags = Tag.find_all_by_id(tag_ids)
  		else 
  			@my_tags = []
  		end
  	end
    @mocs = Post.all
    @trending_mocs = Post.all
  end
  def about
  end
  def how
  end
  def survey
  end
end
