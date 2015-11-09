require 'rails_helper'

RSpec.describe "chapters/edit", type: :view do
  before(:each) do
    @chapter = assign(:chapter, Chapter.create!(
      :number => 1,
      :title => "MyString",
      :content => "MyText",
      :author => nil,
      :story => nil
    ))
  end

  it "renders the edit chapter form" do
    render

    assert_select "form[action=?][method=?]", chapter_path(@chapter), "post" do

      assert_select "input#chapter_number[name=?]", "chapter[number]"

      assert_select "input#chapter_title[name=?]", "chapter[title]"

      assert_select "textarea#chapter_content[name=?]", "chapter[content]"

      assert_select "input#chapter_author_id[name=?]", "chapter[author_id]"

      assert_select "input#chapter_story_id[name=?]", "chapter[story_id]"
    end
  end
end
