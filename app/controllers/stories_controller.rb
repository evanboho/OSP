class StoriesController < ApplicationController

  def index
    @stories = Story.approved
  end

  def show
    @story = Story.find(params[:id])
  end

  def random
    @story = Story.approved.order("RANDOM()").first
    render 'show' if @story
    redirect_to root_path, :notice => "There are no stories." if @story.nil?
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



end
