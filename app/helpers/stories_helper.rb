module StoriesHelper

  def line_breaks(graphs)
    return graphs.split("\n") if !graphs.nil?
    return [] if graphs.nil?
  end


  def approver
    if @story.present?
      @story.approver
    end
  end

end
