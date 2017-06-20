require 'spec_helper'

describe "deck play" do

  it "should let you discard/undiscard a card"

  it "should not change discarded/undiscarded status when a card is drawn"

  it "should undiscard all cards when the 'deal' button is pressed"

  context "with a deck with 'use deck' enabled" do
    # this spec will pass 5% of the time even if the functionality is broken
    it "should always add cards marked 'always draw' to the hand"

    it "should draw a new hand when 'deal' is pressed"

    it "should immediately draw a hand on page load"

    it "should disable the 'draw' button when all cards are drawn"
  end

  context "with a deck with 'use deck' disabled" do
    it "should immediately draw all cards on page load"

    it "should not display a 'draw' button at all"

    it "should still display all cards when 'deal' is pressed"
  end

  context "with a deck with 'readyable' enabled" do
    it "should only add readied cards to the deck"
  end

  context "with a deck with 'readyable' disabled" do
    it "should add cards to the deck regardless of them being readied"
  end
end
