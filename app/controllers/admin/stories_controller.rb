class Admin::StoriesController < AdminController
  before_filter :authenticate_admin!
  before_filter :find_story, only: [:show, :edit, :update, :destroy]

  def edit
  end

  def update
    @story.update(story_params)
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

  private

  def story_params
    params.require(:story).permit(:approve, :approved_by)
  end

end
