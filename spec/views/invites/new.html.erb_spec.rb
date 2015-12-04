require 'rails_helper'

RSpec.describe "invites/new", type: :view do
  before(:each) do
    assign(:invite, Invite.new(
      :key => "MyString",
      :used => false,
      :user => nil
    ))
  end

end
