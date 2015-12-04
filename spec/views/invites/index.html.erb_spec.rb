require 'rails_helper'

RSpec.describe "invites/index", type: :view do
  before(:each) do
    assign(:invites, [
      Invite.create!(
        :key => "Key",
        :used => false,
        :user => nil
      ),
      Invite.create!(
        :key => "Key",
        :used => false,
        :user => nil
      )
    ])
  end

  it "renders a list of invites" do
    render
    assert_select "tr>td", :text => "Key".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
