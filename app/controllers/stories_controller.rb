class StoriesController < ApplicationController
  before_action :find_story, only: [:show, :update]

  def index
    @stories = Story.approved
  end

  def show
    if @story
      @comments = @story.comments.approved.order(created_at: :desc)
      @comment = @story.comments.new
      @unapproved_comments = @story.comments.unapproved.order(:created_at => :desc) if current_user?
    else
      redirect_to root_path, :notice => "We couldn't find that story."
    end
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params.merge(approved_by: current_user))
    if @story.save
      flash[:notice] = "Thank you for your contribution."
      redirect_to stories_path
    else
      flash[:error] = "There was a problem with your contribution."
      render 'new'
    end
  end

protected

  def find_story
    @story = if params[:id] == "read"
      get_random
    else
      Story.find_by(id: params[:id])
    end
  end

  def get_random
    Story.approved.order("RANDOM()").first
  end

  def story_params
    params.require(:story).permit(:name, :age, :title, :body)
  end

end
