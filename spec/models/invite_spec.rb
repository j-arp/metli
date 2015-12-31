require 'rails_helper'

RSpec.describe Invite, type: :model do

  it 'defaults to not being sent' do
    invite = Invite.new
    expect(invite).to_not be_sent
  end

  it 'be marked as sent' do
    invite = Invite.new
    invite.sent = true
    expect(invite).to be_sent
  end

  it 'generates a key on create' do
    invite = Invite.create
    expect(invite.key).to_not be_nil
  end


end
