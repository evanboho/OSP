class Admin::StoriesController < StoriesController

  before_filter :authenticate_admin!

  def edit
    @story = Story.find(params[:id])
  end

  def update
    @story = Story.find(params[:id])
    @story.update_attributes(params[:story])
    redirect_to story_path(@story)
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
    if @story.approve
      flash[:notice] = "Story approved"
      redirect_to story_path(@story)
    else
      flash[:error] = "Something went wrong"
      redirect_to story_path(@story)
    end
  end

  def disapprove
    @story = Story.find(params[:id])
    if @story.disapprove
      flash[:notice] = "Story disapproved."
      redirect_to story_path(@story)
    else
      flash[:error] = "Story not disapproved."
      redirect_to story_path(@story)
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