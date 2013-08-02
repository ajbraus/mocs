class PostsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  # GET /posts
  # GET /posts.json
  def index
    if params[:search].present?
      @recently_added = Post.search(params[:search], with: { published: true }, :page => params[:page], :per_page => 10)
      @highest_rated = Post.search(params[:search], with: { published: true }, :page => params[:page], :per_page => 10)
      @popular_now = Post.search(params[:search], with: { published: true }, order: 'last_touched asc', :page => params[:page], :per_page => 10)
      # @posts_by_participants = @mocs.sort_by { |m| m.commitments.count }
      # @posts_by_organization = Post.search(params[:search], with: { organization: current_user.organization, published: true }, :page => params[:page], :per_page => 10)
    else 
      @recently_added = Post.where(published: true).order('published_at desc').paginate(:page => params[:page], :per_page => 10)
      @highest_rated = Post.where(published: true).paginate(:page => params[:page], :per_page => 10)
      @popular_now = Post.where(published: true).order( "last_touched asc" ).paginate(:page => params[:page], :per_page => 10)
      # @posts_by_participants = Post.sort_by { |m| m.commitments.count }
      # @posts_by_organization = Post.includes(:user).where("user.organizations CONTAINS ?, published = ?", current_user.organization, true).paginate(:page => params[:page], :per_page => 10)
    end
    @trending_mocs = Post.first(3)
    @trending_tags = Tag.first(20)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end    
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.paginate(:page => params[:page], :per_page => 10)
    @mocs = Post.first(5)
    if user_signed_in?
      @post.create_activity :show, owner: current_user
      @commitment = current_user.commitments.find_by_commitment_id(@post.id)
      if @commitment.present?
        @percent_complete = @commitment.percent_complete
      end
    end


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
    @post.state = @user.state
    @post.last_touched = Time.now

    if params[:commit] == "Publish"
      @post.published = true
      @post.published_at = Time.now
    else
      @post.published = false
    end

    respond_to do |format|
      if @post.save
        if params[:commit] == "Publish"
          @post.create_activity :published, owner: current_user
        else
          @post.create_activity :create, owner: current_user
        end
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

    if params[:commit] == "Publish"
      @post.published = true
      @post.published_at = Time.now
    elsif params[:commit] == "Delete"
      @post.destroy
      redirect_to user_posts_path, notice: "Project successfully deleted."
      return
    else 
      @post.published = false
    end

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
      format.html { redirect_to root_path, notice: "Project was successfully removed." }
      format.json { head :no_content }
    end
  end
end
