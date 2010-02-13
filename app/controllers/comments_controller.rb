class CommentsController < ApplicationController
  before_filter :login_required
  before_filter :get_story

  # POST /stories/1/comments/1/radd
  # POST /stories/1/comments/1/radd.xml
  def radd
    @comment = Comment.find(params[:id])
    
    respond_to do |format|
      if @comment.vote(true, current_user)
        flash[:notice] = 'You have upvoted this comment!'
        format.html { redirect_to(@story) }
        format.xml  { render :xml => @story, :status => :created, :location => @story }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # POST /stories/1/comments/1/bury
  # POST /stories/1/comments/1/bury.xml
  def bury
    @comment = Comment.find(params[:id])
    
    respond_to do |format|
      if @comment.vote(false, current_user)
        flash[:notice] = 'You have downvoted this comment.'
        format.html { redirect_to(@story) }
        format.xml  { render :xml => @story, :status => :created, :location => @story }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /stories/1/comments/new
  # GET /stories/1/comments/new.xml
  def new
    @comment = @story.comments.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /stories/1/comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /stories/1/comments
  # POST /stories/1/comments.xml
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

  # PUT /stories/1/comments/1
  # PUT /stories/1/comments/1.xml
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

  # DELETE /stories/1/comments/1
  # DELETE /stories/1/comments/1.xml
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
