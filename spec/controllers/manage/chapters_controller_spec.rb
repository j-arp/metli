require 'rails_helper'
require 'support/user_with_supscriptions_context'

RSpec.describe Manage::ChaptersController, type: :controller do
  include_context "user_with_supscriptions"
  # This should return the minimal set of attributes required to create a valid
  # Chapter. As you add validations to Chapter, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryGirl.attributes_for(:chapter)
  }

  let(:invalid_attributes) {
    {title: ''}
  }

  let(:story) { @story }

  describe "GET #index" do
    it "assigns all chapters as @chapters" do
      get :index, {story_id: @story.permalink}, valid_author_session
      expect(assigns(:chapters)).to eq(@story.chapters)
    end
  end

  describe "GET #show" do
    it "assigns the requested chapter as @chapter" do
      get :show, {story_id: @story.permalink, :id => @story.chapters.first.to_param}, valid_author_session
      expect(assigns(:chapter)).to eq(@story.chapters.first)
    end
  end

  describe "GET #new" do
    it "assigns a new chapter as @chapter" do
      get :new, {story_id: @story.permalink}, valid_author_session
      expect(assigns(:chapter)).to be_a_new(Chapter)
    end
  end

  describe "GET #edit" do
    it "assigns the requested chapter as @chapter" do
      get :edit, {story_id: @chapter.story.permalink, :id => @chapter.to_param}, valid_author_session
      expect(assigns(:chapter)).to eq(@chapter)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Chapter" do
        expect {
          post :create, {story_id: @story.permalink, :chapter => FactoryGirl.attributes_for(:chapter, {story_id: @story.permalink})}, valid_author_session
        }.to change(Chapter, :count).by(1)
      end

      it "assigns a newly created chapter as @chapter" do
        post :create, {story_id: @story.permalink, :chapter => valid_attributes}, valid_author_session
        expect(assigns(:chapter)).to be_a(Chapter)
        expect(assigns(:chapter)).to be_persisted
      end

      it "redirects to the created chapter" do
        post :create, {story_id: @story.permalink, :chapter => valid_attributes}, valid_author_session
        @story.reload
        #broken :why?
        # expect(response).to redirect_to(manage_story_chapter_path(@story.permalink, @story.chapters.last.id))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved chapter as @chapter" do
        post :create, {story_id: @story.permalink, :chapter => invalid_attributes}, valid_author_session
        expect(assigns(:chapter)).to be_a_new(Chapter)
      end

      it "re-renders the 'new' template" do
        post :create, {story_id: @story.permalink, :chapter => invalid_attributes}, valid_author_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {title: 'new chapter title'}
      }

      it "updates the requested chapter" do
        put :update, {story_id: @chapter.story.permalink, :id => @chapter.to_param, :chapter => new_attributes}, valid_author_session
        @chapter.reload
        expect(@chapter.title).to eq 'new chapter title'
      end

      it "assigns the requested chapter as @chapter" do
        put :update, {story_id: @chapter.story.permalink, :id => @chapter.to_param, :chapter => valid_attributes}, valid_author_session
        expect(assigns(:chapter)).to eq(@chapter)
      end

      it "redirects to the chapter" do
        put :update, {story_id: @chapter.story.permalink, :id => @chapter.id, :chapter => valid_attributes}, valid_author_session
        expect(response).to redirect_to(manage_story_chapter_path(@story.permalink, @chapter))
      end
    end

    context "with invalid params" do
      it "assigns the chapter as @chapter" do
        put :update, {story_id: @chapter.story.permalink, :id => @chapter.to_param, :chapter => invalid_attributes}, valid_author_session
        expect(assigns(:chapter)).to eq(@chapter)
      end

      it "re-renders the 'edit' template" do
        put :update, {story_id: @chapter.story.permalink, :id => @chapter.to_param, :chapter => invalid_attributes}, valid_author_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested chapter" do
      expect {
        delete :destroy, {story_id: @chapter.story.permalink, :id => @chapter.to_param}, valid_author_session
      }.to change(Chapter, :count).by(-1)
    end

    it "redirects to the chapters list" do
      delete :destroy, {story_id: @chapter.story.permalink, :id => @chapter.to_param}, valid_author_session
      expect(response).to redirect_to(manage_story_chapters_path)
    end
  end

end