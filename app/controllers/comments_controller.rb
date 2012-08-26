class CommentsController < ApplicationController

  def index
    @comments = Comment.unapproved
  end
  
  def create
    @comment = Comment.create(params[:comment])
    redirect_to @comment.story
  end
  
  def approve
    @comment = Comment.find(params[:id])
    @comment.approved_by = current_user.id
    if @comment.save
      redirect_to comments_path, :notice => "Comment approved"
    else
      render 'index', :notice => "something went wrong"
    end
  end
  
  
end