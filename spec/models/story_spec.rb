require 'rails_helper'

RSpec.describe Story, type: :model do

  context 'scopes' do

    it 'returns all available stories for a user' do
      user = FactoryGirl.create(:user)
      story1 = FactoryGirl.create(:story)
      story2 = FactoryGirl.create(:story)
      user.subscribe_to(story1, 'jesse')

      expect(Story.available(user)).to eq [story2]
    end
  end

end
