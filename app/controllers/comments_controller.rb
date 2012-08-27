class CommentsController < ApplicationController

  def index
    @comments = Comment.unapproved
  end
  
  def create
    @comment = Comment.create(params[:comment])
    if current_user?
      @comment.approved_by = current_user.id
      @comment.save
    end
    redirect_to @comment.story, :notice => "Success! Your comment will be shown once it is approved."
  end
  
end