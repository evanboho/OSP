require 'rails_helper'

describe PagesController, type: :controller do

  describe "root" do
    it "visits" do
      get :index
    end
  end

  describe "show" do
    it "visits pages" do
      %w(about contact contest resources settings writing_tips).each do |page|
        get :show, page: page
        expect(response).to render_template(page)
      end
    end
  end

end
