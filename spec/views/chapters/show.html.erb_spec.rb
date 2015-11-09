require 'rails_helper'

RSpec.describe "chapters/show", type: :view do
  before(:each) do
    @chapter = assign(:chapter, Chapter.create!(
      :number => 1,
      :title => "Title",
      :content => "MyText",
      :author => nil,
      :story => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
