class WelcomeController < ApplicationController
  def index
    @mocs = Post.all
    @trending_mocs = Post.first(5)
    @tags = Tag.first(15)
  end
  def about
  end
  def how
  end
  def survey
  end
end
