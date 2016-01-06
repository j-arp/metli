require 'rails_helper'

RSpec.describe HomeController, type: :controller do


  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders the about page" do
      get :index
      expect(response).to render_template(:about)
    end

    it "redirects to choosing a story if logged in" do
      user = FactoryGirl.create(:user)
      get :index,{},{user_id: user.id}
      expect(response).to redirect_to(choose_story_path)
    end


  end

  describe "GET #about" do
    it "returns http success" do
      get :about
      expect(response).to have_http_status(:success)
    end
  end

end
