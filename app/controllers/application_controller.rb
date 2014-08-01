class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_navbar_counts, :excfept => :current_user?
  after_action :allow_iframe

  def allow_iframe
    response.headers.except! 'X-Frame-Options'
  end

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
      unapproved_comment_stories = Comment.unapproved.includes(:story).collect(&:story)
      @unapproved_comments_count = unapproved_comment_stories.first.nil? ? 0 : unapproved_comment_stories.count
    end
  end

  def method_missing(method, *args)
    method = method.to_s
    if method =~ /find_/
      klass = method.gsub("find_", "")
      instance_variable_set(eval(":@#{klass}"), klass.classify.constantize.find(params[:id]))
    else
      super
    end
  end

end
