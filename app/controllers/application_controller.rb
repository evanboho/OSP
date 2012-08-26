class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_navbar_counts

  helper_method :current_user, :current_user?
  

  def current_user
    current_admin
  end

  def current_user?
    admin_signed_in?
  end


  def load_navbar_counts
    if current_user?
      @approved_story_count = Story.approved.count
      @unapproved_story_count = Story.unapproved.count
      @unapproved_comment_count = Comment.unapproved.count
    end
  end

end
