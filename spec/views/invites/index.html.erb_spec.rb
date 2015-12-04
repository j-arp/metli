require 'rails_helper'

RSpec.describe "invites/index", type: :view do
  before(:each) do
    assign(:invites, [
      Invite.create!(
        :key => "Key",
        :used => false,
        :user => nil
      ),
      Invite.create!(
        :key => "Key",
        :used => false,
        :user => nil
      )
    ])
  end
end
