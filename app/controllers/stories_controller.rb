class StoriesController < ApplicationController

  def index
    @stories = Story.all

  end

  def new
    @story = Story.new

  end

  def create
    @story = Story.create(params[:story])

  end

end
