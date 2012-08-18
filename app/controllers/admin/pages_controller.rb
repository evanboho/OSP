class Admin::PagesController < PagesController
  before_filter :authenticate_admin!

  def resources
    @setting = Setting.new
    @settings = Setting.resources.order(:id)
    render 'pages/admin_resources'
  end


end

