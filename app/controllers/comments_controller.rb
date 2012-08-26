class CommentsController < ApplicationController

  def index
    @comments = Comment.unapproved
  end
  
  def create
    @comment = Comment.create(params[:comment])
    redirect_to @comment.story, :notice => "Success! Your comment will be shown once it is approved."
  end
  
  def approve
    @comment = Comment.find(params[:id])
    @comment.approved_by = current_user.id
    if @comment.save
      redirect_to @comment.story, :notice => "Comment approved"
    else
      redirect_to @comment.story, :notice => "Something went wrong :/"
    end
  end
  
  def unapprove
    @comment = Comment.find(params[:id])
    @comment.approved_by = nil
    if @comment.save
      redirect_to @comment.story, :notice => "Comment unapproved"
    else
      redirect_to @comment.story, :notice => "Something went wrong :/"
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @story = @comment.story
    if @comment.destroy
      flash[:notice] = "Comment deleted"
    else
      flash[:notice] = "Something went wrong :/"
    end
    redirect_to @story
  end
  
  
end