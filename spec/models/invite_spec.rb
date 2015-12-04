require 'rails_helper'

RSpec.describe Invite, type: :model do

  it 'generates a key on create' do
    invite = Invite.create
    expect(invite.key).to_not be_nil
  end
end
