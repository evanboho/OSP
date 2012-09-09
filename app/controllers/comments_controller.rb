class CommentsController < ApplicationController

  def index
    @comments = Comment.unapproved
  end
  
  def create
    @comment = Comment.create(params[:comment])
    if @comment.save
      if current_user?
        @comment.update_attribute(:approved_by, current_user.id)
      end
      flash[:notice] = "Success! Your comment will be shown once it is approved."
    end
    redirect_to @comment.story 
  end
  
end