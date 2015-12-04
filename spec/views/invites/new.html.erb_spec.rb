require 'rails_helper'

RSpec.describe "invites/new", type: :view do
  before(:each) do
    assign(:invite, Invite.new(
      :key => "MyString",
      :used => false,
      :user => nil
    ))
  end

  it "renders new invite form" do
    render

    assert_select "form[action=?][method=?]", invites_path, "post" do

      assert_select "input#invite_key[name=?]", "invite[key]"

      assert_select "input#invite_used[name=?]", "invite[used]"

      assert_select "input#invite_user_id[name=?]", "invite[user_id]"
    end
  end
end
