require 'rails_helper'
require 'support/user_with_supscriptions_context'

RSpec.describe Manage::InvitesController, type: :controller do
  include_context "user_with_supscriptions"

  let(:valid_attributes) {
    {}
  }

  let(:user){
    FactoryGirl.create(:user, {super_user: true})
  }

  let(:valid_session) { {user_id: user.id} }

  describe "GET #index" do
    it "assigns all invites as @invites" do
      invite = Invite.create
      get :index, {}, valid_session
      expect(assigns(:invites)).to eq([invite])
    end
  end

  describe "GET #show" do
    it "assigns the requested invite as @invite" do
      invite = Invite.create! valid_attributes
      get :show, {:id => invite.to_param}, valid_session
      expect(assigns(:invite)).to eq(invite)
    end
  end

  describe "Post #approve" do
    it "mark invite as sent" do
      invite = FactoryGirl.create(:invite, {sent: false, user_requested: true, creator: @author, user: @author})
      post :approve, {:id => invite.to_param}, valid_session
      expect(assigns(:invite).sent).to eq true
    end

    it "send an email to user" do
      invite = FactoryGirl.create(:invite, {sent: false, user_requested: true, creator: @author, user: @author})
      expect(NotifierMailer).to receive(:new_story_code_created).once.with(invite.id).and_call_original
      post :approve, {:id => invite.to_param}, valid_session
    end

    it "wont send an email to user if already sent" do
      invite = FactoryGirl.create(:invite, {sent: true, user_requested: true, creator: @author, user: @author})
      expect(NotifierMailer).to_not receive(:new_story_code_created)
      post :approve, {:id => invite.to_param}, valid_session

    end


  end

  describe "GET #new" do
    it "assigns a new invite as @invite" do
      get :new, {}, valid_session
      expect(assigns(:invite)).to be_a_new(Invite)
    end
  end


  describe "POST #create" do
    context "with valid params" do
      it "creates a new Invite" do
        expect {
          post :create, {:invite => valid_attributes}, valid_session
        }.to change(Invite, :count).by(1)
      end

      it "assigns a newly created invite as @invite" do
        post :create, {:invite => valid_attributes}, valid_session
        expect(assigns(:invite)).to be_a(Invite)
        expect(assigns(:invite)).to be_persisted
      end

      it "ties a newly created invite creating users" do
        post :create, {:invite => valid_attributes}, valid_session

        expect(assigns(:invite).creator).to eq user
      end

      it "redirects to back to list" do
        post :create, {:invite => valid_attributes}, valid_session
        expect(response).to redirect_to(manage_invites_path)
      end
    end

  end

  describe "DELETE #destroy" do
    it "destroys the requested invite" do
      invite = Invite.create
      expect {
        delete :destroy, {:id => invite.to_param}, valid_session
      }.to change(Invite, :count).by(-1)
    end

    it "redirects to the invites list" do
      invite = Invite.create
      delete :destroy, {:id => invite.to_param}, valid_session
      expect(response).to redirect_to(manage_invites_url)
    end
  end

end
