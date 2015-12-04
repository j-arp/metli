require 'rails_helper'

RSpec.describe "invites/edit", type: :view do
  before(:each) do
    @invite = assign(:invite, Invite.create!(
      :key => "MyString",
      :used => false,
      :user => nil
    ))
  end

  it "renders the edit invite form" do
    render

    assert_select "form[action=?][method=?]", invite_path(@invite), "post" do

      assert_select "input#invite_key[name=?]", "invite[key]"

      assert_select "input#invite_used[name=?]", "invite[used]"

      assert_select "input#invite_user_id[name=?]", "invite[user_id]"
    end
  end
end
