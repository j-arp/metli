require 'rails_helper'
require 'support/user_with_supscriptions_context'

RSpec.describe Manage::StoriesController, type: :controller do
  include_context "user_with_supscriptions"

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:story)
  }

  let(:invalid_attributes) {
    {name: ''}
  }

  describe "GET #index" do
    it "assigns all stories as @stories" do
      get :index, {}, valid_session.merge(user_id: @author.id)
      expect(assigns(:stories)).to eq(@author.authored_stories)
    end
  end

  describe "GET #show" do
    it "assigns the requested story as @story" do
      story = Story.create! valid_attributes
      get :show, {:id => story.to_param}, valid_session
      expect(assigns(:story)).to eq(story)
    end
  end

  describe "GET #new" do
    it "assigns a new story as @story" do
      get :new, {}, valid_session
      expect(assigns(:story)).to be_a_new(Story)
    end
  end

  describe "GET #edit" do
    it "assigns the requested story as @story" do
      story = Story.create! valid_attributes
      get :edit, {:id => story.to_param}, valid_session
      expect(assigns(:story)).to eq(story)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Story" do
        expect {
          post :create, {:story => valid_attributes}, valid_session
        }.to change(Story, :count).by(1)
      end

      it "assigns a newly created story as @story" do
        post :create, {:story => valid_attributes}, valid_session
        expect(assigns(:story)).to be_a(Story)
        expect(assigns(:story)).to be_persisted
      end

      it "redirects to the created story" do
        post :create, {:story => valid_attributes}, valid_session
        expect(response).to redirect_to(manage_story_path(Story.last))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved story as @story" do
        post :create, {:story => invalid_attributes}, valid_session
        expect(assigns(:story)).to be_a_new(Story)
      end

      it "re-renders the 'new' template" do
        post :create, {:story => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {name: 'new name'}
      }

      it "updates the requested story" do
        story = Story.create! valid_attributes
        put :update, {:id => story.to_param, :story => new_attributes}, valid_session
        story.reload
        expect(story.name).to eq 'new name'
      end

      it "assigns the requested story as @story" do
        story = Story.create! valid_attributes
        put :update, {:id => story.to_param, :story => valid_attributes}, valid_session
        expect(assigns(:story)).to eq(story)
      end

      it "redirects to the story" do
        story = Story.create! valid_attributes
        put :update, {:id => story.to_param, :story => valid_attributes}, valid_session
        expect(response).to redirect_to(redirect_to(manage_story_path(story)))
      end
    end

    context "with invalid params" do
      it "assigns the story as @story" do
        story = Story.create! valid_attributes
        put :update, {:id => story.to_param, :story => invalid_attributes}, valid_session
        expect(assigns(:story)).to eq(story)
      end

      it "re-renders the 'edit' template" do
        story = Story.create! valid_attributes
        put :update, {:id => story.to_param, :story => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested story" do
      story = Story.create! valid_attributes
      expect {
        delete :destroy, {:id => story.to_param}, valid_session
      }.to change(Story, :count).by(-1)
    end

    it "redirects to the stories list" do
      story = Story.create! valid_attributes
      delete :destroy, {:id => story.to_param}, valid_session
      expect(response).to redirect_to(manage_stories_url)
    end
  end

end
