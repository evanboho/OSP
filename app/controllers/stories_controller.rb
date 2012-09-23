class StoriesController < ApplicationController

  def index
    @stories = Story.approved
  end

  def show
    @story = Story.find_by_id(params[:id])
    @story = random if params[:id] == "read"
    show_story
  end

  def random
    @story = Story.approved.order("RANDOM()").first
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(params[:story])
    if current_user?
      @story.admin_id = current_user.id 
      @story.approved_at = Time.now
    end    
    if @story.save
      flash[:notice] = "Thank you for your contribution."
      redirect_to stories_path
    else
      flash[:error] = "something went wrong"
      render 'new'
    end
  end
  
protected
  def show_story
    if @story
      @comments = @story.comments.approved
      @comment = @story.comments.new
      @unapproved_comments = @story.comments.unapproved if current_user?
      
    else
      redirect_to root_path, :notice => "We couldn't find that story."
    end
  end
      


end
