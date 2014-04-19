class Admin::CommentsController < ApplicationController
  before_filter :find_comment, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin!

  def edit
    @comment = Comment.find(params[:id])
    @story = @comment.story
    render 'comments/edit'
  end

  def update
    @comment.update(comment_params)
    redirect_to @comment.story
  end

  def destroy
    @story = @comment.story
    if @comment.destroy
      flash[:notice] = "Comment deleted"
    else
      flash[:notice] = "Something went wrong :/"
    end
    redirect_to @story
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :content, :story_id, :approve, :approved_by)
  end

end
