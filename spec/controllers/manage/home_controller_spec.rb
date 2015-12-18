require 'rails_helper'
require 'support/user_with_supscriptions_context'

RSpec.describe Manage::HomeController, type: :controller do
  include_context "user_with_supscriptions"

  let(:valid_session){
    {user_id: @super_user.id}
  }

  describe "GET #index" do
    it "returns http success" do
      get :index, {}, valid_session
      expect(response).to have_http_status(:success)
    end
  end

end
