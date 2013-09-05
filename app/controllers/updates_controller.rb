class UpdatesController < ApplicationController
  before_filter :authenticate_user!
  # GET /updates/1/edit
  def edit
    @update = Update.find(params[:id])
    @post = @update.post
  end

  # POST /updates
  # POST /updates.json
  def create
    @parent = Post.find(params[:post_id])
    @update = @parent.updates.build(params[:update])

    respond_to do |format|
      if @update.save
        @parent.last_touched = Time.now
        @parent.save
        @parent.committed_users.each do |cu|
          Notifier.delay.update(cu, @parent, @update)
        end
        format.html { redirect_to @parent, notice: 'Update was successfully created.' }
        format.json { render json: @update, status: :created, location: @update }
      else
        format.html { render action: "new" }
        format.json { render json: @update.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /updates/1
  # PUT /updates/1.json
  def update
    @update = Update.find(params[:id])
    @post = @update.post

    respond_to do |format|
      if @update.update_attributes(params[:update])
        format.html { redirect_to @post, notice: 'Update was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @update.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /updates/1
  # DELETE /updates/1.json
  def destroy
    @update = Update.find(params[:id])
    @post = @update.post
    @update.destroy

    respond_to do |format|
      format.html { redirect_to @post }
      format.json { head :no_content }
    end
  end
end
