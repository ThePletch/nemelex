require 'rails_helper'

describe Card do
  describe "#readyable?" do
    it "returns the readyability of its parent deck" do
      readyable_deck = FactoryGirl.create(:readyable_deck)
      readyable_card = FactoryGirl.create(:card, deck: readyable_deck)

      unreadyable_deck = FactoryGirl.create(:river_deck)
      unreadyable_card = FactoryGirl.create(:card, deck: unreadyable_deck)

      expect(readyable_card).to be_readyable
      expect(unreadyable_card).not_to be_readyable
    end
  end
end
