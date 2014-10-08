class Admin::StoriesController < AdminController
  before_filter :authenticate_admin!
  before_filter :find_story, only: [:new_featured, :show, :edit, :update, :destroy]

  def edit
  end

  def update
    params[:story][:approved_by] = if params[:story].delete(:approve) == 'true'
      current_user.id
    else
      nil
    end
    @story.update(story_params)
    redirect_to story_path(@story)
  end

  def approved
    @stories = Story.approved.order(:created_at)
    render 'index'
  end

  def unapproved
    @stories = Story.unapproved.order(:created_at)
    render 'index'
  end

  def featured
    @story = Story.featured.first
    @stories = Story.order('featured desc').approved
    render 'admin/featured'
  end

  def new_featured
    @story.feature!
    @stories = Story.approved
    redirect_to admin_featured_story_path
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
    params.require(:story).permit(:approve, :name, :email, :phone, :approved_by, :title, :body)
  end

  def find_story
    @story = Story.find params[:id]
  end

end
