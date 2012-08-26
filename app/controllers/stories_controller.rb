class StoriesController < ApplicationController

  def index
    @stories = Story.approved
  end

  def show
    @story = Story.find(params[:id])
    show_story
  end

  def random
    @story = Story.approved.order("RANDOM()").first
    show_story
  end

  def new
    @story = Story.new

  end

  def create
    @story = Story.new(params[:story])
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
      @comment = @story.comments.new
      render 'show' 
    else
      redirect_to root_path, :notice => "There are no stories."
    end
  end
      


end
