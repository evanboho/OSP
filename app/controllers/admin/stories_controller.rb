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

  def featured
    @story = Story.featured.first
    @stories = Story.order('featured desc').approved
    render 'admin/featured'
  end
  
  def new_featured
    Story.featured.all.each do |story|
      story.update_attribute(:featured, false)
    end
    @story = Story.find(params[:featured])
    @story.update_attribute(:featured, true)
    @stories = Story.approved
    render 'admin/featured'
  end

  def approve
    @story = Story.find(params[:id])
    if @story.approve(current_user.id)
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
      flash[:notice] = "Story unapproved."
      redirect_to story_path(@story)
    else
      flash[:error] = "Story not unapproved."
      redirect_to story_path(@story)
    end
  end
  
  def with_unapproved_comments
    @stories = Comment.unapproved.collect(&:story)
    if !@stories.first.nil?
      redirect_to stories_path, :notice => "no more stories with unapproved comments"
    else
      render 'index'
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