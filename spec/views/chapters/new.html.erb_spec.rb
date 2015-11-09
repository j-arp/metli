require 'rails_helper'

RSpec.describe "chapters/new", type: :view do
  before(:each) do
    assign(:chapter, Chapter.new(
      :number => 1,
      :title => "MyString",
      :content => "MyText",
      :author => nil,
      :story => nil
    ))
  end

  it "renders new chapter form" do
    render

    assert_select "form[action=?][method=?]", chapters_path, "post" do

      assert_select "input#chapter_number[name=?]", "chapter[number]"

      assert_select "input#chapter_title[name=?]", "chapter[title]"

      assert_select "textarea#chapter_content[name=?]", "chapter[content]"

      assert_select "input#chapter_author_id[name=?]", "chapter[author_id]"

      assert_select "input#chapter_story_id[name=?]", "chapter[story_id]"
    end
  end
end
