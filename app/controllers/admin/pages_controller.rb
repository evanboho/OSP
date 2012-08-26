class Admin::PagesController < PagesController
  before_filter :authenticate_admin!
  before_filter :load_admin_counts

end

