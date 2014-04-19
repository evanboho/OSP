class CommentsController < ApplicationController
  before_filter :find_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = Comment.unapproved
  end

  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      if current_user?
        @comment.update_attribute(:approved_by, current_user.id)
      end
      flash[:notice] = "Success! Your comment will be shown once it is approved."
    end
    redirect_to @comment.story
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :content, :story_id)
  end

end
