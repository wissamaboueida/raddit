class CommentsController < ApplicationController
  before_filter :login_required
  before_filter :get_story

  # GET /posts/1/comments/new
  # GET /posts/1/comments/new.xml
  def new
    @comment = @story.comments.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /posts/1/comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /posts/1/comments
  # POST /posts/1/comments.xml
  def create
    @comments = @story.comments
    @comment = @story.comments.new(params[:comment])
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to(@story) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render 'stories/show' }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1/comments/1
  # PUT /posts/1/comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@story) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1/comments/1
  # DELETE /posts/1/comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end

protected
  
  def get_story
    @story = Story.find(params[:story_id])
  end
  
end
