require 'rails_helper'

RSpec.describe "invites/show", type: :view do
  before(:each) do
    @invite = assign(:invite, Invite.create!(
      :key => "Key",
      :used => false,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Key/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
