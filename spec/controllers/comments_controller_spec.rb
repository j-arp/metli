require 'rails_helper'
require 'support/user_with_supscriptions_context'

RSpec.describe CommentsController, type: :controller do
  include_context "user_with_supscriptions"

  let(:valid_attributes) {
    {content: "i am a comment", chapter_id: @chapter.id, user_id:@user.id}
  }

  describe "GET #list" do
    it "returns http success" do
      comment = FactoryGirl.create(:comment, valid_attributes)
      get :list, {chapter_id: @chapter.id}, valid_session
      expect(response).to have_http_status(:success)
      expect(assigns(:comments)).to eq @chapter.comments
    end
  end

  describe "GET #add" do
    it "returns http success" do
      post :add, {chapter_id: @chapter.id, content: 'hi comments section'}, valid_session
      expect(response).to have_http_status(:success)
    end

    it "creates a new Comment" do
      expect {
        post :add, {chapter_id: @chapter.id, content: 'hi comments section'}, valid_session
      }.to change(Comment, :count).by(1)
    end

    it "assigns a newly created comment as @comment" do
      post :add, {chapter_id: @chapter.id, content: 'hi comments section'}, valid_session
      expect(assigns(:comment)).to be_a(Comment)
      expect(assigns(:comment)).to be_persisted
    end

  end

  describe "GET #remove" do
    it "returns http success" do
      comment = FactoryGirl.create(:comment, valid_attributes)
      expect {
        delete :remove, {comment_id: comment.id}, valid_session
      }.to change(Comment, :count).by(-1)
    end
  end

  describe "GET #flag" do
    it "returns http success" do
      comment = FactoryGirl.create(:comment, valid_attributes)
      get :flag, {comment_id: comment.id}, valid_session
      expect(response).to have_http_status(:success)
    end
  end

end
