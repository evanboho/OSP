class AdminsController < ApplicationController
  
  before_filter :authenticate_admin!
  
  def add
    @admin = Admin.new(params[:admin])    
    if @admin.save
      redirect_to admin_settings_admins_path, :notice => "Admin created!"
    else
      flash[:error] = "We couldn't do that!"
      redirect_to admin_settings_admins_path
    end
  end
  
  def remove
    @admin = Admin.find(params[:id])
    @admin.destroy
    redirect_to admin_settings_admins_path, :notice => "admin removed"
  end
  
  
end