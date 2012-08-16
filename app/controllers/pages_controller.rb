class PagesController < ApplicationController
  def index
    @stories = Story.order('created_at').limit(5)
  end

  def resources
  end

  def contact_us
  end

  def about
  end
end
