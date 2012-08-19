class Admin::PagesController < PagesController
  before_filter :authenticate_admin!


end

