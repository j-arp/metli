require 'rails_helper'

RSpec.describe "stories/new", type: :view do
  before(:each) do
    assign(:story, Story.new(
      :name => "MyString",
      :active => false,
      :taxonomy => "MyText"
    ))
  end

  it "renders new story form" do
    render

    assert_select "form[action=?][method=?]", stories_path, "post" do

      assert_select "input#story_name[name=?]", "story[name]"

      assert_select "input#story_active[name=?]", "story[active]"

      assert_select "textarea#story_taxonomy[name=?]", "story[taxonomy]"
    end
  end
end
