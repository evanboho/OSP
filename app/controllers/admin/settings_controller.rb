class Admin::SettingsController < ApplicationController


  def update
    @setting = Setting.find(params[:id])
    @setting.update_attributes(params[:setting])
    redirect_to admin_pages_resources_path
  end

  def create
    @setting = Setting.new(params[:setting])
    @setting.page = "resources"
    if @setting.save
      flash[:notice] = "Link added!"
    else
      flash[:error] = "Something went wrong!"
    end
    redirect_to admin_pages_resources_path
  end

  def destroy
    if Setting.find(params[:id]).destroy
      flash[:notice] = "Link deleted!"
    else
      flash[:error] = "Something went wrong! :("
    end
    redirect_to admin_pages_resources_path
  end

end