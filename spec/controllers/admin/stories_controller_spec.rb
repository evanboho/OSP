require 'rails_helper'

describe Admin::StoriesController, type: :controller do
  before(:each) do
    Story.destroy_all
    @admin = Fabricate(:admin)
    sign_in @admin
    @story = Fabricate(:story)
  end

  after(:each) { Story.destroy_all }

  describe "index" do
    before(:each) do
      @unapproved = Fabricate(:story, approved_at: nil)
    end

    it "gets approved stories" do
      expect(@story.approved?).to be true
      get :approved
      expect(assigns[:stories]).to_not include(@unapproved)
      expect(assigns[:stories]).to include(@story)
    end

    it "gets unapproved stories" do
      expect(@story.approved?).to be true
      get :unapproved
      expect(assigns[:stories]).to include(@unapproved)
      expect(assigns[:stories]).to_not include(@story)
    end
  end

  describe "featured" do
    before(:each) { @story.update(featured: true) }

    it "gets featured story" do
      get :featured
      expect(assigns[:story]).to eq @story
    end

    it "chooses new featured story" do
      new_story = Fabricate(:story)
      post :new_featured, id: new_story.id
      expect(new_story.reload.featured).to be true
      expect(@story.reload.featured).to be false
    end
  end

  describe "approval" do

    before(:each) do
      @story.update(approved_by: nil)
    end

    it "approves" do
      expect(@story.approved?).to be false
      patch :update, id: @story, story: { approve: 'true' }
      expect(@story.reload.approved?).to be true
    end
  end

  describe "disapproval" do

    it "disapproves" do
      expect(@story.approved?).to be true
      patch :update, id: @story, story: { approve: 'false' }
      expect(@story.reload.approved?).to be false
    end
  end

  describe "updates" do

    it "gets edit" do
      get :edit, id: @story.id
    end

    it "updates" do
      new_body = Faker::Lorem.paragraph
      patch :update, id: @story, story: { body: new_body }
      expect(@story.reload.body).to eq new_body
      new_title = Faker::Lorem.sentence.titleize
      patch :update, id: @story, story: { title: new_title }
      expect(@story.reload.title).to eq new_title
    end

  end

  describe "deletes" do

    it "deletes" do
      expect {
        delete :destroy, id: @story.id
      }.to change(Story, :count).by -1
    end
  end

end
