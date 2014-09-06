require 'rails_helper'

describe StoriesController, type: :controller do

  before(:all) do
    if Story.count != 5
      Story.destroy_all
      5.times { Fabricate(:story) }
    end
    @story = Story.last
  end

  describe "index" do

    it "lists approved stories" do
      get :index
      expect(assigns(:stories).count).to eq 5
    end

    it "does not show unapproved stories" do
      unapproved = Fabricate(:story, approved_at: nil)
      get :index
      expect(assigns(:stories)).to_not include(unapproved)
    end

  end

  describe "show" do

    it "gets" do
      get :show, id: @story.id
      expect(assigns[:story]).to eq @story
    end

    it "returns approved comments" do
      2.times { Fabricate(:comment, story: @story) }
      get :show, id: @story.id
      expect(assigns[:comments].length).to be 0
      @story.comments.first.update(approved_by: Fabricate(:admin))
      get :show, id: @story.id
      expect(assigns[:comments].length).to be 1
    end

  end

  describe "random" do

    it "gets" do
      get :show, id: 'read'
      expect(assigns[:story].class).to eq Story
    end
  end

  describe "create" do

    it "gets new" do
      get :new
    end

    it "creates with valid attributes" do
      expect {
        post :create, story: Fabricate.build(:story, approved_at: nil).attributes
      }.to change(Story, :count).by(1)
    end

    it "does not create with valid attributes" do
      expect {
        post :create, story: Fabricate.build(:story, title: nil, approved_at: nil).attributes
        expect(response).to render_template :new
        expect(flash[:error]).to eq 'There was a problem with your contribution.'
      }.to_not change(Story, :count)
      expect {
        post :create, story: Fabricate.build(:story, body: nil, approved_at: nil).attributes
        expect(response).to render_template :new
        expect(flash[:error]).to eq 'There was a problem with your contribution.'
      }.to_not change(Story, :count)
    end

    describe "as admin" do

      before(:each) do
        sign_in Fabricate(:admin)
      end

      it "creates with valid attributes" do
        expect {
          post :create, story: Fabricate.build(:story, approved_at: nil).attributes
        }.to change(Story, :count).by(1)
        expect(Story.last.approved?).to be true
      end

      it "does not create with valid attributes" do
        expect {
          body = Faker::Lorem.paragraph
          post :create, story: Fabricate.build(:story, body: body, title: nil, approved_at: nil).attributes
          expect(response).to render_template :new
          expect(flash[:error]).to eq 'There was a problem with your contribution.'
          expect(assigns[:story].body).to eq body
        }.to_not change(Story, :count)
        expect {
          title = Faker::Lorem.paragraph
          post :create, story: Fabricate.build(:story, title: title, body: nil, approved_at: nil).attributes
          expect(response).to render_template :new
          expect(flash[:error]).to eq 'There was a problem with your contribution.'
          expect(assigns[:story].title).to eq title
        }.to_not change(Story, :count)
      end

    end
  end

end
