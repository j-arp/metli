require "rails_helper"
require 'support/user_with_supscriptions_context'

RSpec.describe "Login Redirect", :type => :request do
  include_context "user_with_supscriptions"


  describe 'redirect to login' do
    it "stores requested url in cookie and leads to login " do
      get "/story/chapter/#{@chapter.number}"
      expect(response).to redirect_to(login_path)
      expect(response.cookies['return_to']).to eq "/story/chapter/#{@chapter.number}"
    end
  end


end
