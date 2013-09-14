class PostsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  impressionist :actions=>[:show]
  # GET /posts
  # GET /posts.json
  def index
    if params[:oofta] == 'true'
      flash.now[:warning] = "We're sorry, an error occured"
    end

    if params[:goal_ids]
      @goals = params[:goal_ids].map(&:to_i)
    else
      @goals = Goal.pluck(:id)
    end

    if params[:price_range]
      @price_range = params[:price_range][0].split('..').map{|d| Integer(d)}
      @price_range = @price_range[0]..@price_range[1]
    else
      @price_range = 0..10000000
    end

    if params[:speciality_ids]
      @specialities = params[:speciality_ids].map(&:to_i)
    elsif user_signed_in?
      @specialities = current_user.specialities.pluck(:id)
    end

    if params[:organization]
      @organization = params[:organization][0].to_i
    else
      @organization = 0
    end

    if params[:search].present?
      if @organization == 0
        @relevance = Post.search(params[:search], with: { published: true, goal_id: @goals, price: @price_range, speciality_ids: @specialities }, :page => params[:page], :per_page => 7)      
        @popular_now = Post.search(params[:search], with: { published: true, goal_id: @goals, price: @price_range, speciality_ids: @specialities }, order: 'last_touched asc', :page => params[:page], :per_page => 7)      
        @recently_added = Post.search(params[:search], with: { published: true, goal_id: @goals, price: @price_range, speciality_ids: @specialities }, order: 'published_at desc', :page => params[:page], :per_page => 7)
        @time_commitment = Post.search(params[:search], with: { published: true, goal_id: @goals, price: @price_range, speciality_ids: @specialities }, order: 'expected_time asc', :page => params[:page], :per_page => 7)
        @weeks_long = Post.search(params[:search], with: { published: true, goal_id: @goals, price: @price_range, speciality_ids: @specialities }, order: 'duration asc', :page => params[:page], :per_page => 7)
        @moc_credits = Post.search(params[:search], with: { published: true, goal_id: @goals, price: @price_range, speciality_ids: @specialities }, order: 'credits asc', :page => params[:page], :per_page => 7)
      else
        @relevance = Post.search(params[:search], with: { published: true, goal_id: @goals, price: @price_range, org_id: @organization, speciality_ids: @specialities }, :page => params[:page], :per_page => 7)
        @popular_now = Post.search(params[:search], with: { published: true, goal_id: @goals, price: @price_range, org_id: @organization, speciality_ids: @specialities }, order: 'last_touched asc', :page => params[:page], :per_page => 7)              
        @recently_added = Post.search(params[:search], with: { published: true, goal_id: @goals, price: @price_range, org_id: @organization, speciality_ids: @specialities }, order: 'published_at desc', :page => params[:page], :per_page => 7)
        @time_commitment = Post.search(params[:search], with: { published: true, goal_id: @goals, price: @price_range, org_id: @organization, speciality_ids: @specialities }, order: 'expected_time asc', :page => params[:page], :per_page => 7)
        @weeks_long = Post.search(params[:search], with: { published: true, goal_id: @goals, price: @price_range, org_id: @organization, speciality_ids: @specialities }, order: 'duration asc', :page => params[:page], :per_page => 7)
        @moc_credits = Post.search(params[:search], with: { published: true, goal_id: @goals, price: @price_range, org_id: @organization, speciality_ids: @specialities }, order: 'credits asc', :page => params[:page], :per_page => 7)
      end
    else
      if @organization == 0
        @recently_added = Post.joins(:specialities).where(published: true, goal_id: @goals, price: @price_range, posts_specialities: { speciality_id: @specialities }).uniq.order('published_at desc').paginate(:page => params[:page], :per_page => 7)
        @popular_now = Post.joins(:specialities).where(published: true, goal_id: @goals, price: @price_range, posts_specialities: { speciality_id: @specialities }).uniq.order( "last_touched asc" ).paginate(:page => params[:page], :per_page => 7)
        @time_commitment = Post.joins(:specialities).where(published: true, goal_id: @goals, price: @price_range, posts_specialities: { speciality_id: @specialities }).uniq.order( "expected_time asc").paginate(:page => params[:page], :per_page => 7)
        @weeks_long = Post.joins(:specialities).where(published: true, goal_id: @goals, price: @price_range, posts_specialities: { speciality_id: @specialities }).uniq.order( "duration asc").paginate(:page => params[:page], :per_page => 7)
        @moc_credits = Post.joins(:specialities).where(published: true, goal_id: @goals, price: @price_range, posts_specialities: { speciality_id: @specialities }).uniq.order( "credits asc").paginate(:page => params[:page], :per_page => 7)
      else
        @recently_added = Post.joins(:specialities).where(published: true, goal_id: @goals, price: @price_range, organization_id: @organization, posts_specialities: { speciality_id: @specialities }).uniq.order('published_at desc').paginate(:page => params[:page], :per_page => 7)
        @popular_now = Post.joins(:specialities).where(published: true, goal_id: @goals, price: @price_range, organization_id: @organization, posts_specialities: { speciality_id: @specialities }).uniq.order( "last_touched asc" ).paginate(:page => params[:page], :per_page => 7)
        @time_commitment = Post.joins(:specialities).where(published: true, goal_id: @goals, price: @price_range, organization_id: @organization, posts_specialities: { speciality_id: @specialities }).uniq.order( "expected_time asc").paginate(:page => params[:page], :per_page => 7)
        @weeks_long = Post.joins(:specialities).where(published: true, goal_id: @goals, price: @price_range, organization_id: @organization, posts_specialities: { speciality_id: @specialities }).uniq.order( "duration asc").paginate(:page => params[:page], :per_page => 7)
        @moc_credits = Post.joins(:specialities).where(published: true, goal_id: @goals, price: @price_range, organization_id: @organization, posts_specialities: { speciality_id: @specialities }).uniq.order( "credits asc").paginate(:page => params[:page], :per_page => 7)        
      end
    end

    @trending_mocs = Post.where(published: true).order( "last_touched asc" ).first(3)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end    
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.paginate(:page => params[:page], :per_page => 10, order: 'created_at desc')
    @mocs = Post.first(5)
    @update = @post.updates.build
    if user_signed_in?
      @last_show = PublicActivity::Activity.where(owner_id: current_user.id, trackable_id: @post.id).last
      unless @last_show.present? && @last_show.created_at > Date.yesterday
        @post.create_activity :show, owner: current_user
      end

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
    @post = current_user.posts.build

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
    @post = current_user.posts.build(params[:post])
    @post.state = current_user.state
    @post.organization = current_user.organization
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
        Notifier.delay.new_post(@post)
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
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
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
