require 'rails_helper'

RSpec.describe "comments/new", type: :view do
  before(:each) do
    assign(:comment, Comment.new(
      :content => "MyString",
      :user => nil,
      :chapter => nil,
      :is_flagged => false
    ))
  end

  it "renders new comment form" do
    render

    assert_select "form[action=?][method=?]", comments_path, "post" do

      assert_select "input#comment_content[name=?]", "comment[content]"

      assert_select "input#comment_user_id[name=?]", "comment[user_id]"

      assert_select "input#comment_chapter_id[name=?]", "comment[chapter_id]"

      assert_select "input#comment_is_flagged[name=?]", "comment[is_flagged]"
    end
  end
end
