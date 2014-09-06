class Admin::CommentsController < ApplicationController
  before_filter :find_comment, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin!

  def edit
    @story = @comment.story
    render 'comments/edit'
  end

  def update
    params[:comment][:approved_by] = if params[:comment].delete(:approve) == 'true'
      current_user.id
    else
      nil
    end
    @comment.update(comment_params)
    respond_to do |format|
      format.html { redirect_to @comment.story }
      format.js { }
    end
  end

  def destroy
    @story = @comment.story
    if @comment.destroy
      flash[:notice] = "Comment deleted"
    else
      flash[:notice] = "Something went wrong :/"
    end
    respond_to do |format|
      format.html { redirect_to @story }
      format.js { }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :content, :story_id, :approve, :approved_by)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

end
