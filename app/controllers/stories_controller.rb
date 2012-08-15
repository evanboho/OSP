class StoriesController < ApplicationController

  def index
    @stories = Story.approved
  end

  def approved
    @stories = Story.approved
    render 'index'
  end

  def unapproved
    @stories = Story.unapproved
    render 'index'
  end

  def approve
    @story = Story.find(params[:id])
    @story.approved_at = Time.now
    if @story.save
      flash[:notice] = "Story approved!"
      render @story
    else
      flash[:error] = "Oops: Story not approved."
      render 'show'
    end
  end

  def disapprove
    @story = Story.find(params[:id])
    @story.approved_at = nil
    if @story.save
      flash[:notice] = "Story disapproved."
      redirect_to admin_unapproved_stories_path
    else
      flash[:error] = "Oops: Story not disapproved."
      render 'show'
    end
  end

  def show
    @story = Story.find(params[:id])
  end
  def random
    @story = Story.order("RANDOM()").first
    render 'show'
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

  def destroy
    @story = Story.find(params[:id])
    if @story.destroy
      flash[:notice] = "Story deleted"
      redirect_to stories_path
    else
      flash[:error] = "Story not deleted"
      render 'show'
    end
  end

end
