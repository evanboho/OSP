class PagesController < ApplicationController
  def index
    @stories = Story.order('created_at').limit(5)
    @featured = Story.featured.first
  end

  def resources
    @settings = Setting.resources.order(:id)
  end

  def contact_us
  end

  def about

  end

  def setting

  end
  
  def writing_tips
  end
end
