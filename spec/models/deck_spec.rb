require 'rails_helper'

describe Deck do
  describe "#types" do
    it "returns all subtypes" do
      expect(Deck.types.keys).to match_array(%w(HoldEm Maneuver River))
    end

    it "lists the uses_deck and readyable attributes of each subtype" do
      Deck.types.values.each do |metadata|
        expect(metadata).to have_key :uses_deck
        expect(metadata).to have_key :readyable
      end
    end
  end
end
