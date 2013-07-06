class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    if params[:search]
      @search_query = params[:search]
      @posts = Post.search(params[:search], field_weights: {tag_name: 7, title: 3})
      # Search options:
      #   order: :name
      #   page: 1, per_page: 20
      #   conditions: {name: "Batman"}
      #   with: {author_id: 2}
      #   with: {created_at: 3.weeks.ago..Time.zone.now}
      #   field_weights: {name: 20, content: 10, author_name: 5}
      #   match_mode: :boolean   
      @tags_from_results = []
      @tags_near_you = []
      @trending_tags = Tag.last(8)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end    
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @mocs = Post.first(5)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @user = current_user
    @post = @user.posts.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @user = current_user
    @post = @user.posts.build(params[:post])

    respond_to do |format|
      if @post.save
        @post.create_activity :create, owner: current_user
        format.html { redirect_to @post, notice: 'MOC was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to root_path, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
