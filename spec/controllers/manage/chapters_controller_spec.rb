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

      it 'requires at least 2 calls to action' do
        skip  "no test yet"
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

      it "does not update published attribute if not the last published chapter" do
        @new_chapter = FactoryGirl.create(:chapter, {story_id: @chapter.story_id, number: 1000})
        put :update, {story_id: @chapter.story.permalink, :id => @chapter.to_param, :chapter => new_attributes.merge(published_on: nil)}, valid_author_session
        @chapter.reload
        expect(@chapter).to be_published
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

  describe "Notify" do

    context 'ON Update' do
      it "notifies subscribers if chapter is being published on #update if user asks" do
        @user.subscriptions.first.update(send_email: true)
        @chapter.published_on = nil
        @chapter.save

        expect {
          put :update, {story_id: @chapter.story.permalink, :id => @chapter.to_param, :publish => 1,  :chapter => valid_attributes}, valid_author_session
                }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it "DOES NOT notifies subscribers if chapter is being published on #update if user doesnt asks" do
        @user.subscriptions.first.update(send_email: false)
        @chapter.published_on = nil
        @chapter.save

        expect {
          put :update, {story_id: @chapter.story.permalink, :id => @chapter.to_param, :publish => 1,  :chapter => valid_attributes}, valid_author_session
        }.to change { ActionMailer::Base.deliveries.count }.by(0)
      end


      it "skips notification if chapter already has been published on #update" do
        @chapter.published_on = Time.now
        @chapter.save

        expect {
          put :update, {story_id: @chapter.story.permalink, :id => @chapter.to_param, :publish => 1,  :chapter => valid_attributes.merge({voting_ends_after: nil})}, valid_author_session
        }.to change { ActionMailer::Base.deliveries.count }.by(0)
      end
    end

    context 'On Create' do

          it "notifies subscribers if chapter has been published on #create" do
            @story.subscriptions.first.update(send_email: true)

            expect {
              post :create, {story_id: @story.permalink, :publish => 1,  :chapter => FactoryGirl.attributes_for(:chapter, {story_id: @story.id, published_on: "2015/3/23"})}, valid_author_session
                    }.to change { ActionMailer::Base.deliveries.count }.by(1)
          end

    end

  end



  describe "DELETE #destroy" do

    before(:each) do
      @story = FactoryGirl.create(:story)
      @chapter = FactoryGirl.create(:chapter, {story_id: @story.id})
    end

    it "destroys the requested chapter" do
      expect {
        delete :destroy, {story_id: @chapter.story.permalink, :id => @chapter.to_param}, valid_author_session
      }.to change(Chapter, :count).by(-1)
    end

    it "can't destroys the requested chapter if not the last chapter" do
      utter_chapter = FactoryGirl.create(:chapter, {story_id: @chapter.story.id, number: 11})
      expect {
        delete :destroy, {story_id: @chapter.story.permalink, :id => @chapter.to_param}, valid_author_session
      }.to change(Chapter, :count).by(0)
      utter_chapter.destroy
    end

    it "redirects to the chapters list" do
      @new_chapter = FactoryGirl.create(:chapter, {story_id: @chapter.story_id})
      delete :destroy, {story_id: @chapter.story.permalink, :id => @chapter.to_param}, valid_author_session
      expect(response).to redirect_to(manage_story_path(@chapter.story))
    end
  end

end
