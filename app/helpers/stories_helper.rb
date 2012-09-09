module StoriesHelper

  def approver
    if @story.present?
      @story.approver.email.split('@').first
    end
  end

end
