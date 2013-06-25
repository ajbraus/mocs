class WelcomeController < ApplicationController
  def index
    @mocs = Post.all
    @trending_mocs = Post.all
    @tags = Tag.all
  end
  def about
  end
  def how
  end
  def survey
  end
end
