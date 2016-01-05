require 'rails_helper'
require 'support/user_with_supscriptions_context'

RSpec.describe Manage::StoriesController, type: :controller do
  include_context "user_with_supscriptions"

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:story, {user: @user})
  }

  let(:invalid_attributes) {
    {name: ''}
  }


  describe "Request Chapter code" do

    it "Displays a request invite page" do
      get :request_code, {}, valid_session.merge(user_id: @user.id)

    end

    it "generates and saves a request code" do
      expect {
        post :create_code, {}, valid_session.merge(user_id: @user.id)
      }.to change(Invite, :count).by(1)

    end

    it "sends email out to admins" do
      expect(NotifierMailer).to receive(:new_story_code_request).once.with(user_name: @user.full_name).and_call_original
      post :create_code, {}, valid_session.merge(user_id: @user.id)
    end

    it "sets active user as createor" do
      post :create_code, {}, valid_session.merge(user_id: @user.id)
      expect(assigns(:invite).creator).to eq @user
    end

    it "sets active user as user" do
      post :create_code, {}, valid_session.merge(user_id: @user.id)
      expect(assigns(:invite).user).to eq @user

    end

  end

  describe "GET #index" do
    it "assigns all stories as @stories" do
      get :index, {}, valid_session.merge(user_id: @author.id)
      expect(assigns(:stories)).to eq(@author.authored_stories)
    end
    it "assigns completed stories as @completed_stories" do
      get :index, {}, valid_session.merge(user_id: @author.id)
      expect(assigns(:completed_stories)).to_not be_nil
    end
  end

  describe "GET #show" do
    it "assigns the requested story as @story" do
      story = FactoryGirl.create(:story)

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
      story = FactoryGirl.create(:story)
      get :edit, {:id => story.to_param}, valid_session
      expect(assigns(:story)).to eq(story)
    end
  end

  describe "POST #create" do

    before(:each) do
      @invite = Invite.create
    end

    context 'without invite code' do
      it "does not create a new Story" do
        expect {
          post :create, {invite_code: "blahx3", :story => valid_attributes}, valid_session
        }.to change(Story, :count).by(0)
      end

      it "renders create form again" do
          post :create, {invite_code: "blahx3", :story => valid_attributes}, valid_session
          expect(response).to render_template("new")
      end

    end

    context "with valid params" do

      it "creates a new Story" do
        expect {
          post :create, {invite_code: @invite.key, :story => valid_attributes}, valid_session
        }.to change(Story, :count).by(1)
      end

      it "sets it as active" do
        post :create, {invite_code: @invite.key,:story => valid_attributes}, valid_session
        expect(assigns(:story)).to be_active
      end

      it 'sets active user as creator' do
        post :create, {invite_code: @invite.key,:story => valid_attributes}, valid_session
        expect(assigns(:story).user).to eq @user
      end

      it "assigns a newly created story as @story" do
        post :create, {invite_code: @invite.key,:story => valid_attributes}, valid_session
        expect(assigns(:story)).to be_a(Story)
        expect(assigns(:story)).to be_persisted
      end

      it "redirects to the created story" do
        post :create, {invite_code: @invite.key,:story => valid_attributes}, valid_session
        expect(response).to redirect_to(manage_story_path(Story.last))
      end
    end

    context "with invalid params" do

      it "does not use inivte code" do
        post :create, {invite_code: @invite.key,:story => invalid_attributes}, valid_session
        @invite.reload
        expect(@invite).to_not be_used
      end

      it "assigns a newly created but unsaved story as @story" do
        post :create, {invite_code: @invite.key,:story => invalid_attributes}, valid_session
        expect(assigns(:story)).to be_a_new(Story)
      end

      it "re-renders the 'new' template" do
        post :create, {invite_code: @invite.key, :story => invalid_attributes}, valid_session
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
        story = FactoryGirl.create(:story)
        put :update, {:id => story.to_param, :story => new_attributes}, valid_session
        story.reload
        expect(story.name).to eq 'new name'
      end

      it "assigns the requested story as @story" do
        story = FactoryGirl.create(:story)
        put :update, {:id => story.to_param, :story => valid_attributes}, valid_session
        expect(assigns(:story)).to eq(story)
      end

      it "redirects to the story" do
        story = FactoryGirl.create(:story)
        put :update, {:id => story.to_param, :story => valid_attributes}, valid_session
        expect(response).to redirect_to(redirect_to(manage_story_path(story)))
      end
    end

    context "with invalid params" do
      it "assigns the story as @story" do
        story = FactoryGirl.create(:story)
        put :update, {:id => story.to_param, :story => invalid_attributes}, valid_session
        expect(assigns(:story)).to eq(story)
      end

      it "re-renders the 'edit' template" do
        story = FactoryGirl.create(:story)
        put :update, {:id => story.to_param, :story => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested story" do
      story = FactoryGirl.create(:story)
      expect {
        delete :destroy, {:id => story.to_param}, valid_session
      }.to change(Story, :count).by(-1)
    end

    it "redirects to the stories list" do
      story = FactoryGirl.create(:story)
      delete :destroy, {:id => story.to_param}, valid_session
      expect(response).to redirect_to(manage_stories_url)
    end
  end

  describe "#invitations" do

    describe "#GET" do
      it "assigns @story" do
        get :invitations, {:id => @story.to_param}, valid_session
        expect(assigns(:story)).to_not be_nil
      end
    end

    describe '#post' do

      let(:valid_invitations){
        {email_list: "jonathan@test.edu\r\njesse@test.net" }
      }

      it "creates invitaions for each email" do
        expect(Resque).to receive(:enqueue).exactly(2).times
        post :send_invitations, {:id => @story.to_param, :email_list => valid_invitations[:email_list]}, valid_session
      end

      it "sends email invitaion for each email" do
        # expect {
        #   post :send_invitations, {:id => @story.to_param, :email_list => valid_invitations[:email_list]}, valid_session
        # }.to change { ActionMailer::Base.deliveries.count }.by(2)
      end

      it "skips sending  email invitaion for users already send an email" do
        expect(Resque).to receive(:enqueue).exactly(2).times
        post :send_invitations, {:id => @story.to_param, :email_list => valid_invitations[:email_list]}, valid_session
        # expect {
        #
        # }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end


    end
  end
end
