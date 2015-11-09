require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :first_name => "MyString",
      :last_name => "MyString",
      :username => "MyString",
      :email => "MyString",
      :active => false,
      :author => false,
      :privileged => false,
      :story => nil
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input#user_first_name[name=?]", "user[first_name]"

      assert_select "input#user_last_name[name=?]", "user[last_name]"

      assert_select "input#user_username[name=?]", "user[username]"

      assert_select "input#user_email[name=?]", "user[email]"

      assert_select "input#user_active[name=?]", "user[active]"

      assert_select "input#user_author[name=?]", "user[author]"

      assert_select "input#user_privileged[name=?]", "user[privileged]"

      assert_select "input#user_story_id[name=?]", "user[story_id]"
    end
  end
end
