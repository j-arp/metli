require 'rails_helper'

RSpec.describe Manage::InvitesController, type: :controller do
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

      it "redirects to the created invite" do
        post :create, {:invite => valid_attributes}, valid_session
        expect(response).to redirect_to(manage_invite_path(Invite.last))
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
