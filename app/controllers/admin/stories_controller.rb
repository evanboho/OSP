class Admin::StoriesController < StoriesController

def approve
  @story = Story.find(params[:id])
  @story.approve
  redirect_to story_path(@story)
end

def disapprove
  @story = Story.find(params[:id])
  @story.disapprove
  redirect_to story_path(@story)
end




end