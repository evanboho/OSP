class Admin::CommentsController < ApplicationController
  
  before_filter :authenticate_admin!
  
  def edit
    @comment = Comment.find(params[:id])
    @story = @comment.story
    render 'comments/edit'
  end
  
  def update 
    @comment = Comment.find(params[:id])
    @comment.update_attributes(params[:comment])
    if @comment.story.comments.unapproved.count > 0
      redirect_to @comment.story
    else
      redirect_to admin_stories_with_unapproved_comments_path
    end
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