require 'rails_helper'
require 'support/user_with_supscriptions_context'

RSpec.describe Manage::CommentsController, type: :controller do
  include_context "user_with_supscriptions"

  let(:valid_attributes) {
    {content: "i am a comment", chapter_id: @chapter.id, user_id:@user.id}
  }

  let(:invalid_attributes) {
    {content: "" }
  }

  let(:valid_session) {
    {user_id: @super_user.id} 
  }

  describe "GET #index" do
    it "assigns all comments as @comments" do
      comment = FactoryGirl.create(:comment, valid_attributes)
      get :index, {}, valid_session
      expect(assigns(:comments)).to eq([comment])
    end
  end

  describe "GET #show" do
    it "assigns the requested comment as @comment" do
      comment = FactoryGirl.create(:comment, valid_attributes)
      get :show, {:id => comment.to_param}, valid_session
      expect(assigns(:comment)).to eq(comment)
    end
  end

  describe "GET #new" do
    it "assigns a new comment as @comment" do
      get :new, {}, valid_session
      expect(assigns(:comment)).to be_a_new(Comment)
    end
  end

  describe "GET #edit" do
    it "assigns the requested comment as @comment" do
      comment = FactoryGirl.create(:comment, valid_attributes)
      get :edit, {:id => comment.to_param}, valid_session
      expect(assigns(:comment)).to eq(comment)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create, {:comment => valid_attributes}, valid_session
        }.to change(Comment, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        post :create, {:comment => valid_attributes}, valid_session
        expect(assigns(:comment)).to be_a(Comment)
        expect(assigns(:comment)).to be_persisted
      end

      it "redirects to the created comment" do
        post :create, {:comment => valid_attributes}, valid_session
        expect(response).to redirect_to(manage_comment_path(Comment.last))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        post :create, {:comment => invalid_attributes}, valid_session
        expect(assigns(:comment)).to be_a_new(Comment)
      end

      it "re-renders the 'new' template" do
        post :create, {:comment => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {content: "updated comment"}
      }

      it "updates the requested comment" do
        comment = FactoryGirl.create(:comment, valid_attributes)
        put :update, {:id => comment.to_param, :comment => new_attributes}, valid_session
        comment.reload
        expect(comment.content).to eq "updated comment"
      end

      it "assigns the requested comment as @comment" do
        comment = FactoryGirl.create(:comment, valid_attributes)
        put :update, {:id => comment.to_param, :comment => valid_attributes}, valid_session
        expect(assigns(:comment)).to eq(comment)
      end

      it "redirects to the comment" do
        comment = FactoryGirl.create(:comment, valid_attributes)
        put :update, {:id => comment.to_param, :comment => valid_attributes}, valid_session
        expect(response).to redirect_to(manage_comment_path(comment))
      end
    end

    context "with invalid params" do
      it "assigns the comment as @comment" do
        comment = FactoryGirl.create(:comment, valid_attributes)
        put :update, {:id => comment.to_param, :comment => invalid_attributes}, valid_session
        expect(assigns(:comment)).to eq(comment)
      end

      it "re-renders the 'edit' template" do
        comment = FactoryGirl.create(:comment, valid_attributes)
        put :update, {:id => comment.to_param, :comment => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested comment" do
      comment = FactoryGirl.create(:comment, valid_attributes)
      expect {
        delete :destroy, {:id => comment.to_param}, valid_session
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to the comments list" do
      comment = FactoryGirl.create(:comment, valid_attributes)
      delete :destroy, {:id => comment.to_param}, valid_session
      expect(response).to redirect_to(manage_comments_url)
    end
  end

end
