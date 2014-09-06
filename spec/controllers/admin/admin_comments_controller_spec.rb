require 'rails_helper'

describe Admin::CommentsController, type: :controller do
  before(:each) do
    admin = Fabricate(:admin)
    sign_in admin
    Story.destroy_all
    @story = Fabricate(:story)
    @unapproved = Fabricate(:comment, story: @story, approved_at: nil)
    @comment = Fabricate(:comment, story: @story, approved_at: Time.now)
  end

  describe "approval" do

    it "approves" do
      expect(@unapproved.approved?).to eq false
      patch :update, id: @unapproved.id, comment: { approve: 'true' }
      expect(@unapproved.reload.approved?).to eq true
    end

    it "disapproves" do
      expect(@comment.approved?).to eq true
      patch :update, id: @comment.id, comment: { approve: 'false' }
      expect(@comment.reload.approved?).to eq false
    end

  end

  describe "updates" do

    it "gets edit" do
      get :edit, id: @comment.id
    end

    it "updates" do
      new_name = Faker::Name.first_name
      patch :update, id: @comment.id, comment: { name: new_name }
      expect(@comment.reload.name).to eq new_name
      new_content = Faker::Lorem.sentence
      patch :update, id: @comment.id, comment: { content: new_content }
      expect(@comment.reload.content).to eq new_content
    end

  end

  describe "deletes" do

    it "deletes" do
      expect {
        delete :destroy, id: @comment.id
        expect(response).to redirect_to(@comment.story)
      }.to change(Comment, :count).by(-1)
    end
  end

end
