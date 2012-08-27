class Admin::SettingsController < ApplicationController

  before_filter :authenticate_admin!

  def resources
    @setting = Setting.new
    @settings = Setting.resources.order(:id)
    render 'pages/admin_resources'
  end

  def settings
    @contact_uses = Setting.contact_us
    @contact_us = Setting.new#contact_us.present? ? Setting.contact_us : Setting.new
    render 'pages/settings'
  end



  def update
    @setting = Setting.find(params[:id])
    @setting.update_attributes(params[:setting])
    redirect_to admin_settings_resources_path if @setting.page == "resources"
    redirect_to admin_settings_settings_path if @setting.page == "contact_us"
  end

  def create
    @setting = Setting.new(params[:setting])
    #@setting.page = "resources"
    if @setting.save
      redirect
    else
      flash[:error] = "Something went wrong!"
    end
  end

  def destroy
    @setting = Setting.find(params[:id])
    page = @setting.page == "resources" ? "resources" : "contact_us"
    if Setting.find(params[:id]).destroy
      flash[:notice] = "Deleted!"
      # redirect(page, )
    else
      flash[:error] = "Something went wrong!"
    end
  end

  private

  def redirect(page=nil)
    page ||= @setting.page
    if @setting.page == "contact_us"
      redirect_to admin_settings_settings_path, :notice => "Email added!"
    elsif @setting_page == "resources"
      redirect_to admin_settings_resources_path, :notice => "Link added!"
    else
      redirect_to root_path
    end
  end


end